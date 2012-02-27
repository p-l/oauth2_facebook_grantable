module Devise
  module Models
    module Oauth2FacebookGrantable
      extend ActiveSupport::Concern
      def valid_facebook_access_token?(token)
        fb_user = FbGraph::User.me(token)
        Rails.logger.debug("valide_facebook_access_token? #{fbUser} | #{fbUser.identifier}")
        if(fb_user && fbUser.identifier)
          fb_user.identifer == self.facebook_identifier
        else
          false
        end
      end
    end
  end
end