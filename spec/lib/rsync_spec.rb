require 'spec_helper'

describe Docksync::Rsync do
  before(:all) do
    @rsync = Docksync::Rsync.new(
      cid: 'abcde',
      mute: true
    )
  end

  describe "docksync" do
    it "should install rsync" do
    end

    it "should run rsync" do
    end

    # internal methods
    it "should buid container_copy_command" do
      allow(@rsync).to receive(:docker_inspect).and_return("abcde")
      command = @rsync.container_copy_command('src')
      expect(command).to eq(%Q|boot2docker ssh "cp src /var/lib/docker/aufs/mnt/abcde/tmp/"|)
    end
  end
end