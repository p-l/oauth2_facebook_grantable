module Devise
  module Models
    module Oauth2FacebookGrantable
      extend ActiveSupport::Concern
      def valid_facebook_access_token?(token)
        begin
          @graph = Koala::Facebook::API.new(token)
          fb_user = @graph.get_object("me")
          if(fb_user && fb_user["id"])
            Devise::Oauth2ProvidableFacebook.logger.debug("Oauth2FacebookGrantable => User with facebook identifier \"#{fb_user["id"]}\" was authenticated successfully by Facebook")
            return (fb_user["id"].to_s == self.facebook_identifier.to_s)
          else
            Devise::Oauth2ProvidableFacebook.logger.debug("Oauth2FacebookGrantable => Could not authenticate user.")
            return false
          end
        rescue => e
          Devise::Oauth2ProvidableFacebook.logger.error("Oauth2FacebookGrantable => Could not authenticate user: #{e}")
          return false
        end
      end
    end
  end
end