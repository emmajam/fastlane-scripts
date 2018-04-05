module Fastlane
  module Actions
    module SharedValues
      GET_PROVISIONING_PROFILE_TEAM_ID_CUSTOM_VALUE = :GET_PROVISIONING_PROFILE_TEAM_ID_CUSTOM_VALUE
    end

    class GetProvisioningProfileTeamIdAction < Action
      def self.run(params)
        profile_path = params[:profile]
        UI.message "Provisioning profile: #{profile_path}"

        parsed = FastlaneCore::ProvisioningProfile.parse(profile_path)
        parsed["TeamIdentifier"].first
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
       "Returns the provisioning profile team id for the provided provisioning profile"
      end

      def self.details
        "Returns the provisioning profile team id for the provided provisioning profile"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :profile,
                                       env_name: "FL_GET_PROVISIONING_PROFILE_TEAM_ID_PROFILE_PATH",
                                       description: "The path to a provisioning profile",
                                       optional: false,
                                       verify_block: proc do |value|
                                          UI.user_error!("Couldn't find provisioning profile at path `#{value}`") unless File.exist?(value)
                                       end
                                      )
        ]
      end

      def self.output
        [
          ['GET_PROVISIONING_PROFILE_TEAM_ID', 'The corresponding provisioning profile team id']
        ]
      end

      def self.return_value
        "The returned provisioning profile team id is to be used in an environment variable for Xcode 8+ to use in order to select the correct team id for the given provisioning profile"
      end

      def self.authors
        ["daveolsen"]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
