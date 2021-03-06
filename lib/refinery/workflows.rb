require 'refinerycms-core'
require 'refinerycms-settings'
require 'paper_trail'

module Refinery
  module Workflows
    require 'refinery/workflows/engine'

    class << self
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join("spec/factories").to_s ]
      end
    end
  end
end
