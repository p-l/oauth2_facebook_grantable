module Devise
  module Strategies
    class Oauth2FacebookGrantTypeStrategy < Oauth2GrantTypeStrategy
      def grant_type
        'facebook'
      end

      def authenticate_grant_type(client)
        resource = mapping.to.find_for_authentication(:facebook_identifier => params[:facebook_identifier])
        Rails.logger.debug("Looking for ressource... #{resource}")
        if validate(resource) { resource.valid_facebook_access_token?(params[:facebook_access_token]) }
          Rails.logger.debug("Authenticated OK")
          success! resource
        elsif !halted?
          Rails.logger.debug("*****FACEBOOK**** Authentication FAILED")
          oauth_error! :invalid_grant, 'could not authenticate to facebook'
        end
      end
    end
  end
end

Warden::Strategies.add(:oauth2_facebook_grantable, Devise::Strategies::Oauth2FacebookGrantTypeStrategy)
