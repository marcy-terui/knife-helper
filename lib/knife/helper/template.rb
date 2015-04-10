require 'pathname'
require 'thor/group'

module Knife
  module Helper
    class Template < Thor::Group

      include Thor::Actions

      def initialize(source, target, params={})
        super()
        self.class.source_root(
          Pathname.new(
            File.expand_path("../../../../", __FILE__)
          ).join("templates")
        )
        @source = source
        @target = target
        @params = params
      end

      def flush()
        template(@source, @target,
          @params
        )
      end
    end
  end
end
