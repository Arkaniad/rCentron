require "rubygame"
require_relative 'lib/star'
require_relative 'lib/log'
require_relative 'lib/multiplex'
require_relative 'lib/engine'

include Rubygame
include Centron

engine = Centron::Engine.new
engine.run
