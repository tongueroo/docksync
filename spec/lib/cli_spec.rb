require 'spec_helper'

describe Docksync::CLI do
  before(:all) do
    @args = "--noop"
    @cid = "abcde"
  end

  describe "cli" do
    it "should rsync once and quit" do
      out = execute("bin/docksync rsync #{@cid} #{@args}")
      expect(out).to include("Done rsyncing to container #{@cid}")
    end

    it "should watch files and keep rysncing" do
      out = execute("bin/docksync watch #{@cid} #{@args}")
      expect(out).to include("Watching dir")
    end
  end
end