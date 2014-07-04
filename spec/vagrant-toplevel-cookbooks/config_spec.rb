require "vagrant-toplevel-cookbooks/config"

describe VagrantPlugins::TopLevelCookbooks::Config do
  let(:instance) { described_class.new }

  describe "defaults" do
    subject do
      instance.tap do |o|
        o.finalize!
      end
    end

    its("url")     { should be_nil }
    its("ref")     { should be_nil }
  end

  describe "overriding defaults" do
    it "should use the specified url with 'master' branch as default" do
      instance.url = "https://github.com/some/repo"
      instance.finalize!
      instance.url.should == "https://github.com/some/repo"
      instance.ref.should == "master"
    end

    it "should be possible to specify a different branch" do
      instance.url = "https://github.com/some/repo"
      instance.ref = "my_branch"
      instance.finalize!
      instance.url.should == "https://github.com/some/repo"
      instance.ref.should == "my_branch"
    end

    it "should error if a branch is specified but no url" do
      instance.ref = "my_branch"
      instance.finalize!
      err_hash = instance.validate(nil)
      err_hash['vagrant-toplevel-cookbooks'].size.should == 1
    end
  end
end
