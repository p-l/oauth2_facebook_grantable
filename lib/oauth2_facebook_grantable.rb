require 'devise'
require 'rack/oauth2'
require 'koala'
require 'devise_oauth2_providable'

require 'devise/oauth2_facebook_grantable/strategies/facebook_grant_type'
require 'devise/oauth2_facebook_grantable/models/oauth2_facebook_grantable'

module Devise
  module Oauth2ProvidableFacebook
  end
end

Devise.add_module(:oauth2_facebook_grantable,
  :strategy => true,
  :model => "devise/oauth2_facebook_grantable/models/oauth2_facebook_grantable")
