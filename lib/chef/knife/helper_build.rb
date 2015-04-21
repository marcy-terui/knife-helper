require 'chef'
require 'knife/helper/commands'
require 'knife/helper/config'

class Chef
  class Knife
    class HelperBuild < Chef::Knife

      banner "knife helper build REGEX (option)"

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
        unless @name_args.empty?
          cm = commands.commands.select{|c| Regexp.new(@name_args.first).match(c['name']) }
        else
          cm = commands.commands
        end
        hash = {}
        cm.map! do |c|
          hash[c['name']] = commands.build(c['name'])
        end
        output(ui.presenter.format_for_display(hash))
      end

    end
  end
end
