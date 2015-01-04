require 'spec_helper'

# to run specs with what's remembered from vcr
#   $ rake
# 
# to run specs with new fresh data from aws api calls
#   $ rake clean:vcr ; time rake
describe Docksync::CLI do
  before(:all) do
    @args = "--from Tung"
    @cid = "abcde"
  end

  describe "docksync" do
    it "should rsync once and quit" do
      out = execute("bin/docksync rsync --cid #{@cid}")
      expect(out).to include("Done rsyncing to container #{@cid}")
    end

    it "should watch files and keep rysncing" do
      out = execute("bin/docksync watch --cid #{@cid}")
      expect(out).to include("Done rsyncing to container #{@cid}")
      expect(out).to include("Watching dir: ")
    end
  end
end