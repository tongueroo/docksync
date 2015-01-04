module Docksync
  class Rsync
    def initialize(options)
      @options = options
    end

    def run
      puts "Done rsyncing to container #{@options[:cid]}"
    end
  end
end