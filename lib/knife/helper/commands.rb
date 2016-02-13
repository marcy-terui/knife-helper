require 'chef/mixin/deep_merge'

module Knife
  module Helper
    class Commands

      attr_reader :commands

      def initialize(base, commands, option_sets)
        @base = base
        @commands = commands
        @option_sets = option_sets
      end

      def build(name)
        cmd = ""
        @commands.each do |c|
          if c['name'] == name
            cmd = @base
            cmd << " #{c['command']}" if c.has_key?('command')
            cmd << " '#{c['condition']}'" if c.has_key?('condition') && c['condition']
            options = {}
            option_sets = {}
            c['option_sets'] = Array(c['option_sets']) if c['option_sets'].is_a?(String)
            if c['option_sets'].is_a?(Array)
              c['option_sets'].each do |opts|
                option_set(opts).each do |k,v|
                  option_sets[k] = v
                end
              end
            end
            if c['options'].is_a?(Hash)
              c['options'].each do |k,v|
                options[k] = v
              end
            end
            options = Chef::Mixin::DeepMerge.deep_merge(options, option_sets)
            options.each do |k,v|
              cmd << " #{complete_option(k)}"
              cmd << " #{v}" if v
            end
            break
          end
        end
        cmd
      end

      def exec(name)
        raise "Helper exec finished with non-zero exit code" unless system(build(name))
      end

      def complete_option(opt)
        if opt.length > 1
          "--#{opt}"
        else
          "-#{opt}"
        end
      end

      def option_set(name)
        @option_sets.each {|opts| return opts['options'] if name == opts['name'] }
        Hash.new
      end
    end
  end
end
