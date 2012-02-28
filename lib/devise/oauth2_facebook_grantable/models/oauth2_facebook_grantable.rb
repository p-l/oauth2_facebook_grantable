module Devise
  module Models
    module Oauth2FacebookGrantable
      extend ActiveSupport::Concern
      def valid_facebook_access_token?(token)
        begin
          @graph = Koala::Facebook::API.new(token)
          fb_user = @graph.get_object("me")
          if(fb_user && fb_user["id"])
            fb_user["id"].to_s == self.facebook_identifier.to_s
          else
            if(fb_user)
            end
            false
          end
        rescue => e
          false
        end
      end
    end
  end
end