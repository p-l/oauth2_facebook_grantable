require 'version'
require 'devise'
require 'rack/oauth2'
require 'devise_oauth2_providable'

require './devise/oauth2/strategies/facebook_grant_type.rb'
require './devise/oauth2/models/oauth2_facebook_grantable.rb'

module Oauth2ProvidableFacebook
  class Railties < ::Rails::Railtie
    initializer 'Rails logger' do
      Oauth2ProvidableFacebook.logger = Rails.logger
    end
  end
end

Devise.add_module(:oauth2_facebook_grantable, :strategy => true, :model => "devise/oauth2/models/oauth2_facebook_grantable")
