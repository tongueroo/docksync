module Docksync
  class CLI < Thor
    class Help
      class << self
        def rsync
<<-EOL
Rsync local files to docker container once.

Examples:

  $ docksync rsync --cid abcde
EOL
        end

        def watch
<<-EOL
Watch local files and continuously rsync to container.

Examples:

  $ docksync watch --cid abcde
EOL
        end
      end
    end
  end
end