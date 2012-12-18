ENV["RAILS_ENV"] = "test"
require File.expand_path('../../../config/environment', __FILE__)
require 'rails/test_help'

class FacebookOauthTest < ActionDispatch::IntegrationTest
  fixtures :all

  def setup
    # Create a test client
    @client = Devise::Oauth2Providable::Client.create(:name => "Test Client", :redirect_uri => "test://test", :website => "http://test/")
    @client.save

    # Setup a default user
    @user = users(:user)
    @email_user = users(:email_user)

    # Get facebook application credentials
    fb_key = Yetting.facebook_api_key
    fb_secret = Yetting.facebook_api_secret

    # Create test users
    @test_users = Koala::Facebook::TestUsers.new(:app_id => fb_key, :secret => fb_secret)
    @fb_user = @test_users.create(true, "read_stream")
    @other_fb_user = @test_users.create(true, "read_stream")
    @email_fb_user = @test_users.create(true, "read_stream,email")


    # Associate the facebook user with the default user
    @user.facebook_identifier = @fb_user["id"]
    @user.save

    # Associate the facebook email with the email user
    @email_user.email = @email_fb_user["email"]
    @email_user.save

  end

  def teardown
    @client.destroy
    @test_users.delete(@fb_user)
    @test_users.delete(@other_fb_user)
  end

  test "Authenticate with valide facebook token" do
    post_via_redirect("/oauth/token",
      :format => :json,
      :facebook_identifier => @fb_user["id"],
      :facebook_access_token => @fb_user["access_token"],
      :grant_type => "facebook",
      :client_secret => @client.secret,
      :client_id => @client.identifier)
    assert_response :ok
  end

  test "Authenticate with invalid facebook token" do
    post_via_redirect("/oauth/token",
      :format => :json,
      :facebook_identifier => @fb_user["id"],
      :facebook_access_token => "NOTAVALIDTOKEN",
      :grant_type => "facebook",
      :client_secret => @client.secret,
      :client_id => @client.identifier)
    assert_response :unauthorized
  end

  test "Authenticate with valid token but invalid id" do
    post_via_redirect("/oauth/token",
      :format => :json,
      :facebook_identifier => @other_fb_user["id"],
      :facebook_access_token => @fb_user["access_token"],
      :grant_type => "facebook",
      :client_secret => @client.secret,
      :client_id => @client.identifier)
    assert_response :bad_request
  end

  test "Authenticate with with valid email fallback and token" do
    post_via_redirect("/oauth/token",
      :format => :json,
      :facebook_identifier => @email_fb_user["id"],
      :facebook_access_token => @email_fb_user["access_token"],
      :grant_type => "facebook",
      :client_secret => @client.secret,
      :client_id => @client.identifier)
    assert_response :ok
    user = User.where(:facebook_identifier => @email_fb_user["id"]).first
    assert(user, "User was not updated with valide facebook identifier")
  end

end
