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
    @x += tpf * dx * speed
    @y += tpf * dy * speed
    @z += tpf * dz * speed

    if at_destination?
      @to = world.stations.sample
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

  def dx
    return 0 if x == to.x
    x < to.x ? 1 : -1
  end

  def dy
    return 0 if y == to.y
    y < to.y ? 1 : -1
  end

  def dz
    return 0 if z == to.z
    z < to.z ? 1 : -1
  end
end