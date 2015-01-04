$:.unshift(File.expand_path("../", __FILE__))
require "docksync/version"

module Docksync
  autoload :CLI, 'docksync/cli'
end