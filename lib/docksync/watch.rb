require 'filewatcher'

module Docksync
  class Watch
    def initialize(options)
      @options = options
    end

    def run
      Dir.chdir(@options[:cwd]) do
        puts "Watching dir #{@options[:cwd]}"
        ignore = %w[. .. .git log tmp]
        files = Dir.glob(['.*','*']) - ignore
        return false if @options[:noop]
        Rsync::Install.new(@options).run
        Rsync::Sync.new(@options).run
        FileWatcher.new(files).watch() do |filename, event|
          Rsync::Sync.new(@options).run
        end
      end
    end
  end
end