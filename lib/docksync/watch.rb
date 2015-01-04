module Docksync
  class Watch
    def initialize(options)
      @options = options
    end

    def run
      puts "Watching dir: "
      puts "Done rsyncing to container #{@options[:cid]}"
    end
  end
end