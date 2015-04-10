require 'chef'
require 'knife/helper/commands'
require 'knife/helper/config'

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
          ::Knife::Helper::Config.new(file).data
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

      def default_config_file
        ::File.join(Dir.pwd, ".knife.helper.yml")
      end

    end
  end
end
