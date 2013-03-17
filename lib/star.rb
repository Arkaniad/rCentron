require "rubygame"
include Rubygame

class Star
  def initialize height, width
    @height = height
    @width = width
    @centerx = width / 2
    @centery = height / 2
    scatter
  end
  def refresh
    k = 128.0 / @z
    @screenx = (@x * k + @centerx) + 0.5
    @screeny = (@y * k + @centery) + 0.5
    fade = (1 - (@z / 32.0)) * 255
    @color = [fade, fade, fade]
  end
  def advance
    if self.in_bounds?
      @z = @z - 0.02
      refresh
    else
      self.scatter
    end
  end
  def scatter
    @x = rand(-25.0..25.0)
    @y = rand(-25.0..25.0)
    @z = rand(1.0..32.0)
    refresh
  end
  def in_bounds?
    @screenx < @width and @screeny < @height and @screenx > 0 and @screeny > 0 or @z > 0
  end
  def draw surface
    surface.draw_box [@screenx, @screeny], [@screenx, @screeny], @color
  end
  def blank surface
    surface.draw_box [@screenx, @screeny], [@screenx, @screeny], [0,0,0]
  end
end
