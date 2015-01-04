# Docksync

[![Build Status](https://magnum.travis-ci.com/)](https://magnum.travis-ci.com/)
[![Code Climate](https://codeclimate.com/)](https://codeclimate.com/)
[![Code Climate](https://codeclimate.com/)](https://codeclimate.com/)

Tool to rsync your files from your macosx machine to the docker container.  

Sharing volumes from macosx to the docker host to the container is extremely slow.  In one of our large applications a task that normally takes 15 seconds takes about 5 mins with the shared volume.  This is a 20x performance hit.  The issue is not docker, the issue is that the shared volume is slow.  For small projects sharing volumes is fine, but for larger projects it is too slow for development.  This tool is a hack to sync files from macosx to the docker container.  The tool is useful until shared volumes on macosx is faster.

## How it works

* It installs and setups an rsync server on the running container.
* It then watches for any changed files on your filesystem and will sync them over as needed.
* It uses the WORKDIR configured in your Dockerfile and will rsync the project files there.  
* This only works on ubuntu because it uses apt-get to install the rsync server to the running container.
* This also assumes you are using boot2docker.
* IMPORTANT: You'll need to expose port 873 so that this script works.  You can put this in your Dockerfile, fig.yml or in the docker run command.
* Make sure you are not using volumes, the whole point of this gem is to avoid the volume sharing.

## Installation

  $ gem install docksync

## Usage

  $ docksync watch --container-id [CONTAINER_ID]

Example:

  $ cd project
  $ docksync watch --container-id abcde