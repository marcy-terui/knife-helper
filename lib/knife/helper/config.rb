require 'safe_yaml'
require 'erb'
require 'chef/mixin/deep_merge'

module Knife
  module Helper
    class Config

      attr_reader :settings, :option_sets, :commands

      def initialize(file=nil)
        file ||= default_file
        conf = load_config(file)
        @settings = conf['settings']
        @option_sets = conf['option_sets']
        @commands = conf['commands']
      end

      def load_config(file)
        conf = load_yml(get_content(read_file(file)))
        Array(conf['includes']).each do |inc|
          inc_path = nil
          rel_path = File.expand_path("../#{inc}", file)
          [inc, rel_path].each {|f| inc_path = f if File.exists?(f) }
          raise "'#{inc}' is not exists." if inc_path.nil?
          conf = Chef::Mixin::DeepMerge.deep_merge(
            load_yml(get_content(read_file(inc_path))),
            conf
          )
        end
        conf
      end

      def default_file
        ::File.join(Dir.pwd, ".knife.helper.yml")
      end

      def read_file(file)
        ::File.exist?(file.to_s) ? IO.read(file) : ""
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
