module Devise
  module Strategies
    class Oauth2FacebookGrantTypeStrategy < Oauth2GrantTypeStrategy
      def grant_type
        Devise::Oauth2ProvidableFacebook.logger.debug("Facebook Grant Loaded")
        'facebook'
      end

      def authenticate_grant_type(client)
        Devise::Oauth2ProvidableFacebook.logger.debug("Oauth2FacebookGrantTypeStrategy => Searching for user with facebook identifier:\"#{params[:facebook_identifier]}\"")
        resource = mapping.to.find_for_authentication(:facebook_identifier => params[:facebook_identifier])
        Devise::Oauth2ProvidableFacebook.logger.debug("Oauth2FacebookGrantTypeStrategy => Validating access token for user with facebook identifier:\"#{params[:facebook_identifier]}\"")
        if validate(resource) { resource.valid_facebook_access_token?(params[:facebook_access_token]) }
          Devise::Oauth2ProvidableFacebook.logger.debug("Oauth2FacebookGrantTypeStrategy => Token is valid")
          success! resource
        elsif !halted?
          Devise::Oauth2ProvidableFacebook.logger.debug("Oauth2FacebookGrantTypeStrategy => Token is not valid")
          oauth_error! :invalid_grant, 'could not authenticate to facebook'
        end
      end
    end
  end
end

Warden::Strategies.add(:oauth2_facebook_grantable, Devise::Strategies::Oauth2FacebookGrantTypeStrategy)
