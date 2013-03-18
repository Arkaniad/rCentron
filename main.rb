require "rubygame"
require_relative 'lib/star'
require_relative 'lib/log'
require_relative 'lib/multiplex'
require_relative 'lib/engine'

include Rubygame
include Centron

$VERSION = "rCentron 0.0.9"

engine = Centron::Engine.new
engine.run
