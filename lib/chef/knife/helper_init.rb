require 'chef'
require 'knife/helper/template'

class Chef
  class Knife
    class HelperInit < Chef::Knife

      banner "knife helper init (options)"

      option :use_local_mode,
        :short => "-l",
        :long => "--local",
        :description => "local mode (for zero)",
        :boolean => true,
        :default => false

      option :cookbook_path,
        :short => "-c [PATH1,PATH2...]",
        :long => "--cookbook-path [PATH1,PATH2...]",
        :description => "Path to Cookbooks",
        :default => "../cookbooks,../site-cookbooks"

      option :repo_path,
        :short => "-r PATH",
        :long => "--repo-path PATH",
        :description => "Path to Chef Repogitory",
        :default => "../"

      option :use_berks,
        :short => "-B",
        :long => "--berks",
        :description => "Generate Berksfile",
        :boolean => true,
        :default => false

      option :use_librarian,
        :short => "-L",
        :long => "--librarian",
        :description => "Generate Cheffile",
        :boolean => true,
        :default => false

      def run
        create_helper_yml
        create_knife_rb
        create_berks if config[:use_berks]
        create_librarian if config[:use_librarian]
      end

      private

      def create_helper_yml
        ::Knife::Helper::Template.new("helper.yml.erb", ".knife.helper.yml",
          :exec_path => $0
        ).flush
      end

      def create_knife_rb
        ::Knife::Helper::Template.new("knife.rb.erb", ".chef/knife.rb",
            :local_mode => config[:use_local_mode].to_s,
            :cookbook_path => config[:cookbook_path].split(',').to_s,
            :repo_path => "\"#{config[:repo_path]}\""
        ).flush
      end

      def create_berks
        ::Knife::Helper::Template.new("Berksfile.erb", "Berksfile").flush
      end

      def create_librarian
        ::Knife::Helper::Template.new("Cheffile.erb", "Cheffile").flush
      end
    end
  end
end
