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
        :default => nil

      def run
        conf = ::Knife::Helper::Config.new(config[:file])
        commands = ::Knife::Helper::Commands.new(
          conf.settings['command_base'],
          conf.commands,
          conf.option_sets
        )
        @name_args.each do |cmd|
          if config[:print_command]
            output commands.build(cmd)
          else
            commands.exec(cmd)
          end
        end
      end

    end
  end
end
