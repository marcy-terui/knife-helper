
module Knife
  module Helper
    class Commands

      def initialize(config)
        @base = config['settings']['exec_path']
        @commands = config['commands']
      end

      def build(name)
        cmd = ""
        @commands.each do |c|
          if c['name'] == name
            cmd = @base
            cmd << " #{c['command']}" if c.has_key?('command')
            cmd << " '#{c['condition']}'" if c.has_key?('condition') && c['condition']
            if c['options'].is_a?(Hash)
              c['options'].each do |k,v|
                cmd << " #{complete_option(k)}"
                cmd << " #{v}" if v
              end
            end
            break
          end
        end
        cmd
      end

      def exec(name)
        system(build(name))
      end

      def complete_option(opt)
        if opt.length > 1
          "--#{opt}"
        else
          "-#{opt}"
        end
      end
    end
  end
end
