require 'spec_helper'

describe Docksync::Rsync do
  before(:all) do
    @rsync = Docksync::Rsync.new(
      cid: 'abcde',
      noop: true,
      mute: true
    )
  end

  describe "docksync" do
    it "should install and run rsync" do
      out = @rsync.run # mainly to check syntax of rsync class
      expect(out).to eq "Done rsyncing to container abcde"
    end

  end
end