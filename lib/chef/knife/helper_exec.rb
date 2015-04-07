require 'chef'
require 'safe_yaml'
require 'erb'
require 'knife/helper/commands'

class Chef
  class Knife
    class HelperExec < Chef::Knife

      banner "knife helper exec NAME (option)"

      option :print_command,
        :short => "-p",
        :long => "--print-only",
        :description => "Only print the command that built by helper",
        :boolean => true,
        :default => false

      option :file,
        :short => "-f FILE",
        :long => "--file FILE",
        :description => "Path to config file(yaml)",
        :default => ""

      def run
        file = config[:file] == "" ? default_config_file : config[:file]
        commands = ::Knife::Helper::Commands.new(
          load_yml(get_content(read_file(file)))
        )
        @name_args.each do |cmd|
          if config[:print_command]
            puts commands.build(cmd)
          else
            commands.exec(cmd)
          end
        end
      end

      private

      def read_file(file)
        ::File.exist?(file.to_s) ? IO.read(file) : ""
      end

      def default_config_file
        ::File.join(Dir.pwd, ".knife.helper.yml")
      end

      def get_content(str)
        ::ERB.new(str).result
      end

      def load_yml(str)
        ::SafeYAML.load(str) || Hash.new
      end

    end
  end
end
