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
        check
        Install.new(@options).run unless @options[:skip_install]
        Sync.new(@options).run
      end
      msg = "Done rsyncing to container #{@cid}"
      @options[:mute] ? msg : puts(msg)
    end

    def check
      running = `docker inspect -f {{.State.Running}} #{@cid}`.strip == 'true'
      unless running
        puts "Container #{@cid} is not running".colorize(:red)
        exit 0
      end
    end
  end
end