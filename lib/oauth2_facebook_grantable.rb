require 'devise'
require 'rack/oauth2'
require 'koala'
require 'devise_oauth2_providable'

require 'devise/oauth2_facebook_grantable/strategies/facebook_grant_type'
require 'devise/oauth2_facebook_grantable/models/oauth2_facebook_grantable'

module Devise
  module Oauth2ProvidableFacebook
    def self.logger
      @@logger
    end
    def self.logger=(logger)
      @@logger = logger
    end
    def self.debugging?
      @@debugging
    end
    def self.debugging=(boolean)
      @@debugging = boolean
    end
    class Railties < ::Rails::Railtie
      initializer 'Rails logger' do
        Devise::Oauth2ProvidableFacebook.logger = Rails.logger
      end
    end
  end
end

Devise.add_module(:oauth2_facebook_grantable,
  :strategy => true,
  :model => "devise/oauth2_facebook_grantable/models/oauth2_facebook_grantable")
