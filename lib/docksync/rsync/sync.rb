module Docksync
  class Rsync
    class Sync
      def initialize(options)
        @options = options
        @cid = @options[:cid]
      end

      def dockerhost
        host = `boot2docker ip 2>&1 | grep address | awk '{print $NF}'`.strip # old version of boot2docker
        host = `boot2docker ip`.strip if host.empty?
        host = '192.168.59.103' if host.empty?
        host
      end

      def docker_ps_for_port
        `docker ps | grep #{@cid}`
      end

      def dockerport
        out = docker_ps_for_port
        md = out.match(/0\.0\.0\.0\:(\d+)->873/)
        if md
          md[1]
        else
          msg = "Could not find expose port 873.  Are you sure you exposed port 837 for #{@cid} container?".colorize(:red)
          if @options[:mute]
            return msg
          else
            puts msg
            leave
          end
        end
      end

      def leave
        exit 0
      end

      def run
        puts "Executing: #{command}"
        system(command)
        raise "rsync execution returned failure" if ($?.exitstatus != 0)
      end

      def command
        # --numeric-ids               don't map uid/gid values by user/group name
        # --safe-links                ignore symlinks that point outside the tree
        # -a, --archive               recursion and preserve almost everything (-rlptgoD)
        # -x, --one-file-system       don't cross filesystem boundaries
        # -z, --compress              compress file data during the transfer
        # -S, --sparse                handle sparse files efficiently
        # -v, --verbose               verbose
        exclude = %w/.git tmp log/
        exclude += get_excludes('.gitignore')
        exclude += get_excludes('.dockerignore')
        exclude = exclude.uniq.map{|path| "--exclude='#{path}'"}.join(' ')
        options = "--delete --numeric-ids --safe-links -axzSv #{exclude}"
        src = get_src
        dest = "rsync://#{dockerhost}:#{dockerport}/volume/"

        "rsync #{options} #{src} #{dest}"
      end

      def get_excludes(file)
        exclude = []
        path = "#{@options[:cwd]}/#{file}"
        if File.exist?(path)
          exclude = File.read(path).split("\n")
        end
        result = exclude.map {|i| i.strip}.reject {|i| i =~ /^#/ || i.empty?}
        result
      end

      def get_src
        src = @options[:cwd] || '.'
        src[-1] == '/' ? src : "#{src}/"
      end
    end
  end
end