module Centron
  class Engine
    def initialize
      @mplx = Multiplex.new(STDOUT)
      @log = Log.new(@mplx, "Centron")
      @log.info "Engine Initializing"
      TTF.setup
      @ttf = TTF.new("res/font/ttf-droidsans.ttf", 14)
      @screen = Screen.new([800, 600],0,[Rubygame::HWSURFACE,Rubygame::DOUBLEBUF])
      @screen.title = "Centron Starfield Test"
      @queue = EventQueue.new()
      @clock = Clock.new
      @clock.target_framerate = 60
      @clock.enable_tick_events
      @stars = []
      1000.times do |i|
        @stars.push Star.new(@screen.height, @screen.width)
      end
    end
    def run
      looping = true
      while looping do
        @clock.tick
        @stars.each do |star|
          if star.in_bounds?
            star.draw @screen
          else
            star.scatter
            star.draw @screen
          end
        end
        @screen.flip
        @stars.each do |star|
          star.blank @screen
        end
        @queue.each do |ev|
          case ev
            when QuitEvent
            Rubygame.quit
            return
          end
        end
        @stars.each do |star| star.advance end
      end
    end
  end
end
