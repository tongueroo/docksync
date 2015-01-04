module Docksync
  class CLI < Thor
    class Help
      class << self
        def rsync
<<-EOL
Rsync local files to docker container once.

Examples:

  $ docksync rsync abcde
EOL
        end

        def watch
<<-EOL
Watch local files and continuously rsync to container.

Examples:

  $ docksync watch abcde
EOL
        end
      end
    end
  end
end