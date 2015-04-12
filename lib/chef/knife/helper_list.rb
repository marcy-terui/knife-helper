require 'chef'
require 'knife/helper/commands'
require 'knife/helper/config'

class Chef
  class Knife
    class HelperList < Chef::Knife

      banner "knife helper list REGEX (option)"

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
        unless @name_args.empty?
          cm = commands.commands.select{|c| Regexp.new(@name_args.first).match(c['name']) }
        else
          cm = commands.commands
        end
        cm.map! do |c|
          {
            c['name'] => c['command']
          }
        end
        output(format_for_display(cm))
      end

      private

      def default_config_file
        ::File.join(Dir.pwd, ".knife.helper.yml")
      end

    end
  end
end
