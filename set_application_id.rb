require 'fileutils'
require 'tempfile'

module Fastlane
  module Actions
    module SharedValues
      APPLICATION_ID = :APPLICATION_ID
    end
    class SetApplicationIdAction < Action
      def self.run(params)
        new_id = params[:application_id]
        SetValuesInBuildAction.run(
          app_project_dir: params[:app_project_dir],
          key: "applicationId",
          value: new_id
        )
        Actions.lane_context[SharedValues::APPLICATION_ID] = new_id
        UI.message("Set Application ID to #{new_id} 💐")
        new_id
      end

      #####################################################
      # @!group Documentation
      #####################################################
      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :app_project_dir,
                                  env_name: "ANDROID_VERSIONING_APP_PROJECT_DIR",
                               description: "The path to the application source folder in the Android project (default: android/app)",
                                  optional: true,
                                      type: String,
                             default_value: "android/app"),
          FastlaneCore::ConfigItem.new(key: :application_id,
                                  env_name: "ANDROID_VERSIONING_APPLICATION_ID",
                               description: "Set a specific application id",
                                  optional: false,
                                      type: String)
        ]
      end

      def self.description
        "Set the application id of your project"
      end

      def self.details
        [
          "This action will set the application id directly in build.gradle."
        ].join("\n")
      end

      def self.output
        [
          ['APPLICATION_ID', 'The new application id']
        ]
      end

      def self.authors
        ["Emma Jam"]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
