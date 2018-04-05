require 'tempfile'
require 'fileutils'

module Fastlane
  module Actions
    class SetSentryPropertiesAction < Action
      def self.run(params)
        app_project_dir ||= params[:app_project_dir]
        dashboard = params[:value]
        found = false
        Dir.glob("#{app_project_dir}/sentry.properties") do |path|
          begin
            temp_file = Tempfile.new('sentry')
            File.open(path, 'r') do |file|
              file.each_line do |line|
                unless line.include? "defaults.project" and !found
                  temp_file.puts line
                  next
                end
                line.replace "defaults.project=#{dashboard}"
                found = true
                temp_file.puts line
              end
              file.close
            end
            temp_file.rewind
            temp_file.close
            FileUtils.mv(temp_file.path, path)
            temp_file.unlink
          end
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################
      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :app_project_dir,
                                  env_name: "ANDROID_VERSIONING_APP_PROJECT_DIR",
                               description: "The path to the root folder in the ios/android project (default: android)",
                                  optional: true,
                                      type: String,
                             default_value: "android"),
          FastlaneCore::ConfigItem.new(key: :value,
                               description: "The dashboard value",
                                      type: String)
        ]
      end

      def self.description
        "Set the value of your project"
      end

      def self.details
        [
          "This action will set the value directly in sentry.properties file"
        ].join("\n")
      end

      def self.authors
        ["Emma Jam"]
      end

      def self.is_supported?(platform)
        platform == :android
        platform == :ios
      end
    end
  end
end
