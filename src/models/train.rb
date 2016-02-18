class Train < Pointable
  attr_reader :line, :from, :to

  def initialize(x:, y:, z: 0, line:, from:, to:)
    super(x: x, y: y, z: z)
    @line = line
    @from = from
    @to = to
  end

  def as_geometry(asset_manager)
    box = Box.new(point, 0.3, 0.3, 0.3)

    geo = Geometry.new("Box", box)
    geo.material = coloured_material(ColorRGBA::Red, asset_manager)
    geo
  end

  def simpleUpdate(world, tpf)
    @x += tpf * speed * direction.x
    @y += tpf * speed * direction.y
    @z += tpf * speed * direction.z

    if at_destination?
      @from = to
      @to = @from.possible_destinations(world).sample
    end
  end

  def at_destination?
    (@to.x - x).abs < resolution &&
    (@to.y - y).abs < resolution &&
    (@to.z - z).abs < resolution
  end

  def resolution
    0.1
  end

  def speed
    3
  end

  def direction
    to.point.subtract(point).normalize
  end
end
