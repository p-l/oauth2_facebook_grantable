module Devise
  module Strategies
    class Oauth2FacebookGrantTypeStrategy < Oauth2GrantTypeStrategy
      def grant_type
        'facebook'
      end

      def authenticate_grant_type(client)
        Rails.logger.debug("Searching for user: #{params[:facebook_identifier]}")
        resource = mapping.to.find_for_authentication(:facebook_identifier => params[:facebook_identifier])
        if(!resource)
          Rails.logger.debug("===> FACEBOOK USER WAS NOT FOUND")
        end
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
