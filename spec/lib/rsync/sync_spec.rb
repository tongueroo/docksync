require 'spec_helper'

describe Docksync::Rsync::Sync do
  before(:all) do
    @sync = Docksync::Rsync::Sync.new(
      cid: 'abcde',
      mute: true,
      cwd: 'spec/fixtures/project'
    )
  end

  describe "sync" do
    it "should build command" do
      allow(@sync).to receive(:dockerhost).and_return("192.168.59.103")
      allow(@sync).to receive(:dockerport).and_return("49123")
      # puts @sync.command
      expect(@sync.command).to match %r{rsync://192.168.59.103:49123}
    end

    it "should find exposed port" do
      ps_out = 'Up 41 seconds       0.0.0.0:48001->3000/tcp, 0.0.0.0:49164->873/tcp   cms_web_1'
      allow(@sync).to receive(:docker_ps_for_port).and_return(ps_out)
      expect(@sync.dockerport).to eq "49164"
    end

    it "should give message if exposed port not found" do
      ps_out = 'Up 41 seconds       0.0.0.0:48001->3000/tcp, 0.0.0.0:49164->800/tcp   cms_web_1'
      allow(@sync).to receive(:leave)
      allow(@sync).to receive(:docker_ps_for_port).and_return(ps_out)
      expect(@sync.dockerport).to match /Could not find expose port 873/
    end

    it "should get excludes from .gitignore" do
      exclude = @sync.get_excludes('.gitignore')
      expect(exclude).to include "*.dump"
    end
  end
end