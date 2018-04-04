require 'fileutils'
require 'tempfile'

module Fastlane
  module Actions
    module SharedValues
      HOCKEYAPP_KEY = :HOCKEYAPP_KEY
    end
    class SetHockeyappKeyAction < Action
      def self.run(params)
        new_key = params[:hockeyapp_key]
        SetValuesInBuildAction.run(
          app_project_dir: params[:app_project_dir],
          key: "manifestPlaceholders",
          value: new_key
        )
        Actions.lane_context[SharedValues::HOCKEYAPP_KEY] = new_key
        UI.message('Set HockeyApp Key to #{new_key} 💐')
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
          FastlaneCore::ConfigItem.new(key: :hockeyapp_key,
                                  env_name: "ANDROID_VERSIONING_HOCKEYAPP_KEY",
                               description: "Set a specific hockeyapp key",
                                  optional: false,
                                      type: String)
        ]
      end

      def self.description
        "Set the hockeyapp key of your project"
      end

      def self.details
        [
          "This action will set the hockeyapp key directly in build.gradle."
        ].join("\n")
      end

      def self.output
        [
          ['HOCKEYAPP_KEY', 'The new hockeyapp key']
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
