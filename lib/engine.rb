module Centron
  class Engine
    def initialize
      @mplx = Multiplex.new(STDOUT)
      @log = Log.new(@mplx, "Centron")
      @log.info $VERSION
      @log.info "Engine initializing..."
      @log.info "Fonts initializing..."
      TTF.setup

      @log.info "Loading fonts..."
      @ttf = TTF.new("res/font/ttf-droidsans.ttf", 14)

      @log.info "Initializing event queue..."
      @queue = EventQueue.new()

      @log.info "Initializing timer..."
      @clock = Clock.new
      @clock.target_framerate = 60
      @clock.enable_tick_events

      @log.info "Calibrating timer..."
      @clock.calibrate()
      @log.info "Granularity: %d ms"%[@clock.granularity]

      @log.info "Initializing screen..."
      @screen = Screen.new([800, 600],0,[Rubygame::HWSURFACE,Rubygame::DOUBLEBUF])
      @screen.title = $VERSION

      @log.info "Initializing starfield..."
      @stars = []
      1000.times do |i|
        @stars.push Star.new(@screen.height, @screen.width)
      end
    end
    def run
      @log.info "Running main loop"
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
        msg = @ttf.render "#{$VERSION} | #{@clock.framerate.to_i} FPS", false, [255,255,255]
        msg.blit @screen, [0, @screen.height - msg.height]
        @screen.flip
        clear
        @queue.each do |ev|
          case ev
            when QuitEvent
            @log.info "Quitting."
            Rubygame.quit
            return
          end
        end
        @stars.each do |star| star.advance end
      end
    end
    def clear
      @screen.fill [0, 0, 0]
    end
  end
end
