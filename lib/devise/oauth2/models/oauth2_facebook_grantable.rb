module Devise
  module Models
    module Oauth2FacebookGrantable
      extend ActiveSupport::Concern
      def valid_facebook_access_token?(token)
        true
      end
    end
  end
end