require 'fileutils'
require 'colorize'

module Docksync
  class Rsync
    autoload :Install, 'docksync/rsync/install'
    autoload :Sync, 'docksync/rsync/sync'

    def initialize(options)
      @options = options
      @cid = @options[:cid]
      @cwd = @options[:cwd]
    end

    def run
      unless @options[:noop]
        Install.new(@options).run 
        Sync.new(@options).run
      end
      msg = "Done rsyncing to container #{@cid}"
      @options[:mute] ? msg : puts(msg)
    end
  end
end