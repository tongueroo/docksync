require 'thor'
require 'docksync/cli/help'

module Docksync

  class CLI < Thor
    class_option :mute, :type => :boolean
    class_option :noop, :type => :boolean
    class_option :cwd, :default => '.'

    desc "rsync [CID]", "rsync local changes to container"
    long_desc Help.rsync
    def rsync(cid)
      Rsync.new(options.merge(:cid => cid)).run
    end

    desc "watch [CID]", "watch directory and continuously rsync to container"
    long_desc Help.watch
    def watch(cid)
      Watch.new(options.merge(:cid => cid)).run
    end

  end
end