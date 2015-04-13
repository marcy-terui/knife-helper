require 'chef'
require 'knife/helper/commands'
require 'knife/helper/config'

class Chef
  class Knife
    class HelperList < Chef::Knife

      banner "knife helper list (options)"

      option :file,
        :short => "-f FILE",
        :long => "--file FILE",
        :description => "Path to config file(yaml)",
        :default => nil

      option :all,
        :short => "-a",
        :long => "--all",
        :description => "Print all commands and options",
        :boolean => true,
        :default => false

      def run
        ::Knife::Helper::Commands.new(
          ::Knife::Helper::Config.new(config[:file]).data
        ).commands.each do |c|
          if config[:all]
            output(ui.presenter.format_for_display(c))
          else
            output c['name']
          end
        end
      end

    end
  end
end
