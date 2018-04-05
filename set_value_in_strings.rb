require 'fileutils'
require 'nokogiri'

module Fastlane
  module Actions
    class SetValueInStringsAction < Action
      def self.run(params)
        key = params[:key]
        value = params[:value]

        strings_file = params[:app_project_dir] + "/src/main/res/values/strings.xml"
        @doc = Nokogiri::XML(File.open(strings_file))

        @doc.xpath("//string").each do |node|
          if node.attribute('name').content == key
            node.content = value
          end
        end                
        File.write(strings_file, @doc.to_xml)
        UI.message("Set #{key} as #{value} 💯")
      end

      #####################################################
      # @!group Documentation
      #####################################################
      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :app_project_dir,
                                  env_name: "ANDROID_STRINGS_APP_PROJECT_DIR",
                               description: "The path to the app folder in the Android project (default: android/app",
                                  optional: true,
                                      type: String,
                             default_value: "android/app"),
          FastlaneCore::ConfigItem.new(key: :key,
                                  env_name: "ANDROID_STRINGS_KEY",
                               description: "The key to target",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :value,
                                  env_name: "ANDROID_STRINGS_VALUE",
                               description: "The value to set",
                                  optional: false,
                                      type: String)
        ]
      end

      def self.description
        "Set the value of an entry in the strings.xml file."
      end

      def self.details
        [
          "Set the value of an entry in the strings.xml file."
        ].join("\n")
      end

      def self.output
        []
      end

      def self.authors
        ["Dave Olsen"]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
