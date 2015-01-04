require 'fileutils'

module Docksync
  class Rsync
    def initialize(options)
      @options = options
      @cid = @options[:cid]
    end

    def run
      install
      puts "Done rsyncing to container #{@cid}"
    end

    def install
      return if @options[:noop]
      copy_script
      run_script
    end

    # hacky way to copy file to the container
    def copy_script
      puts "Copying install-rsync.sh script to container"
      # temporarily use home since boot2docker host mounts /Users
      src = File.expand_path("../bash/install-rsync.sh", __FILE__)
      tmp = "#{ENV['HOME']}/#{File.basename(src)}"
      FileUtils.cp(src, tmp)

      # copy to actual container
      system(container_copy_command(tmp))

      # clean up
      FileUtils.rm_f(tmp)
    end

    def container_copy_command(src)
      full_cid = docker_inspect
      dest = "/var/lib/docker/aufs/mnt/#{full_cid}/tmp/"
      cmd = %Q|boot2docker ssh "cp #{src} #{dest}"|
      puts "Running: #{cmd}" unless @options[:mute]
      cmd
    end

    def docker_inspect
      `docker inspect -f '{{.Id}}' #{@cid}`.strip
    end

    def run_script
      puts "Installing rsync to container"
      puts `docker exec #{@cid} /bin/bash -e /tmp/install-rsync.sh #{app_root}`
    end

    def app_root
      # TODO: grab from Dockerfile
    end
  end
end