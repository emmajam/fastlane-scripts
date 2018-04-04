require 'fileutils'
require 'tempfile'

module Fastlane
  module Actions
    module SharedValues
      VERSION_CODE = :VERSION_CODE
    end
    class SetVersionCodeAction < Action
      def self.run(params)
        new_code = params[:version_code]
        SetValuesInBuildAction.run(
          app_project_dir: params[:app_project_dir],
          key: "versionCode",
          value: new_code.to_s
        )
        Actions.lane_context[SharedValues::VERSION_CODE] = new_code
        UI.message("Set Version Code to #{new_code} 🍾")
        new_code
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
          FastlaneCore::ConfigItem.new(key: :version_code,
                                  env_name: "ANDROID_VERSIONING_VERSION_CODE",
                               description: "Set a specific version code",
                                  optional: false,
                                      type: Integer)
        ]
      end

      def self.description
        "Set the application id of your project"
      end

      def self.details
        [
          "This action will set the version code directly in build.gradle."
        ].join("\n")
      end

      def self.output
        [
          ['VERSION_CODE', 'The new version code']
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
