require "vagrant"

module VagrantPlugins
  module ApplicationCookbooks
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
          errors << "url must not be nil if ref is specified" if @url.nil?
        end
        { "vagrant-application-cookbooks" => errors }
      end

      def finalize!
        @url = nil if @url == UNSET_VALUE
        @ref = 'master' if @ref == UNSET_VALUE
      end
    end
  end
end