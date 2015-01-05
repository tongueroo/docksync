ENV['TEST'] = '1'

require "pp"
 
root = File.expand_path('../../', __FILE__)
require "#{root}/lib/docksync"

module Helpers
  def execute(cmd)
    puts "Running: #{cmd}" if ENV['DEBUG']
    out = `#{cmd}`
    puts out if ENV['DEBUG']
    out
  end
end

RSpec.configure do |c|
  c.include Helpers
end