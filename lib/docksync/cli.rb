require 'thor'
require 'docksync/cli/help'

module Docksync

  class CLI < Thor
    class_option :verbose, :type => :boolean
    class_option :noop, :type => :boolean
    class_option :cid, :desc => 'container id'

    desc "rsync", "rsync local changes to container"
    long_desc Help.rsync
    def rsync
      Rsync.new(options).run
    end

    desc "watch", "watch directory and continuously rsync to container"
    long_desc Help.watch
    def watch
      Watch.new(options).run
    end

  end
end