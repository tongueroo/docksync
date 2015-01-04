require 'spec_helper'

describe Docksync::Rsync::Install do
  before(:all) do
    @install = Docksync::Rsync::Install.new(
      cid: 'abcde',
      mute: true
    )
  end

  describe "install" do
    # internal methods
    it "should build container_copy_command" do
      allow(@install).to receive(:docker_inspect).and_return("abcde")
      command = @install.container_copy_command('src')
      expect(command).to eq(%Q|boot2docker ssh "cp src /var/lib/docker/aufs/mnt/abcde/tmp/"|)
    end
  end
end