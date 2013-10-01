require "vagrant-application-cookbooks/config"

describe VagrantPlugins::ApplicationCookbooks::Config do
  let(:instance) { described_class.new }

  # Ensure tests are not affected by AWS credential environment variables
  before :each do
    ENV.stub(:[] => nil)
  end

  describe "defaults" do
    subject do
      instance.tap do |o|
        o.finalize!
      end
    end

    its("url")     { should be_nil }
  end

  describe "overriding defaults" do
    it "should not default url if overridden" do
      instance.url = "foo"
      instance.finalize!
      instance.url.should == "foo"
    end
  end
end
