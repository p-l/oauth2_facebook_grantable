module Devise
  module Strategies
    class Oauth2FacebookGrantTypeStrategy < Oauth2GrantTypeStrategy      

      def valid?
        Oauth2ProvidableFacebook.logger.debug('Test')
      end

      def authenticate!
        Oauth2ProvidableFacebook.logger.debug('Test')
      end

      def grant_type
        Oauth2ProvidableFacebook.logger.debug("Authenticate called")
        'facebook'
      end

      def authenticate_grant_type(client)
        Oauth2ProvidableFacebook.logger.debug("Authenticate called")
        resource = mapping.to.find_for_authentication(mapping.to.authentication_keys.first => params[:facebook_id])
        if validate(resource) { resource.valid_facebook_access_token?(params[:facebook_access_token]) }
          success! resource
        elsif !halted?
          oauth_error! :invalid_grant, 'could not authenticate to facebook'
        end
      end
    end
  end
end


Warden::Strategies.add(:oauth2_facebook_grantable, Devise::Strategies::Oauth2FacebookGrantTypeStrategy)
