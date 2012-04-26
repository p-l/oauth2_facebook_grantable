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

    # Get facebook application credentials
    fb_key = Yetting.facebook_api_key
    fb_secret = Yetting.facebook_api_secret

    # Create test users
    @test_users = Koala::Facebook::TestUsers.new(:app_id => fb_key, :secret => fb_secret)
    @fb_user = @test_users.create(true, "read_stream")
    @other_fb_user = @test_users.create(true, "read_stream")

    # Associate the facebook user with the default user
    @user.facebook_identifier = @fb_user["id"]
    @user.save
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
    assert_response :bad_request
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

end
