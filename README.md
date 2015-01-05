# Docksync


[![Build Status](https://travis-ci.org/tongueroo/docksync.svg?branch=master)](https://travis-ci.org/tongueroo/docksync)
[![Code Climate](https://codeclimate.com/github/tongueroo/docksync/badges/gpa.svg)](https://codeclimate.com/github/tongueroo/docksync)

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

<pre>
$ gem install docksync
</pre>

## Usage

<pre>
$ docksync watch [CONTAINER_ID]
</pre>

Example:

<pre>
$ cd project
$ docksync watch abcde
</pre>

For more help:

<pre>
$ docksync help
</pre>