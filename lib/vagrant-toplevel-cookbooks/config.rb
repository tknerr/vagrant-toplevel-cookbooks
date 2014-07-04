require "vagrant"

module VagrantPlugins
  module TopLevelCookbooks
    class Config < Vagrant.plugin(2, :config)
      
      # git url to clone from
      attr_accessor :url
      # git ref / branch to checkout
      attr_accessor :ref

      def initialize
        @url = UNSET_VALUE
        @ref = UNSET_VALUE
      end

      def validate(machine)
        errors = _detected_errors
        if @ref != nil
          errors << "'toplevel_cookbook.url' must be specified when 'toplevel_cookbook.ref' is used" if @url.nil?
        end
        { "vagrant-toplevel-cookbooks" => errors }
      end

      def finalize!
        @url = nil if @url == UNSET_VALUE
        if @url != nil
          @ref = 'master' if @ref == UNSET_VALUE
        else
          @ref = nil if @ref == UNSET_VALUE
        end
      end
    end
  end
end