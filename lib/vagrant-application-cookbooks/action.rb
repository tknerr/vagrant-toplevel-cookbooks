require 'pathname'

module VagrantPlugins
  module ApplicationCookbooks
    module Action

      def self.action_root
        Pathname.new(File.expand_path("../action", __FILE__))
      end

      autoload :Clone, action_root.join("clone")
    end
  end
end
