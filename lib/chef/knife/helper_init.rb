require "pathname"
require 'chef'
require 'knife/helper'
require "thor/actions"

class Chef
  class Knife
    class HelperInit < Chef::Knife
      include Thor::Actions

      banner "knife helper init (options)"

      option :use_berks,
        :short => "-B",
        :long => "--use-berks",
        :description => "Generate Berksfile",
        :boolean => true,
        :default => false

      option :use_librarian,
        :short => "-L",
        :long => "--use-librarian",
        :description => "Generate Cheffile",
        :boolean => true,
        :default => false

      option :local_mode,
        :short => "-l",
        :long => "--local",
        :description => "Generate Cheffile",
        :boolean => true,
        :default => false

      def run
        self.class.source_root(
          Pathname.new(
            File.expand_path("../../../../", __FILE__).join("templates")
          )
        )

        create_helper_yml
        create_chef_knife_rb
      end

      private

      def create_helper_yml

        template("helper.yml.erb", ".knife.helper.yml",

        )
      end

    end
  end
end
