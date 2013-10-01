require "vagrant"

module VagrantPlugins
  module ApplicationCookbooks
    class Config < Vagrant.plugin(2, :config)
      attr_accessor :url

      def initialize
        @url = UNSET_VALUE
      end

      def validate(machine)
        errors = _detected_errors
        #errors << "url must not be nil" if @url.nil?
        { "vagrant-application-cookbooks" => errors }
      end

      def finalize!
        @url = nil if @url == UNSET_VALUE
      end
    end
  end
end