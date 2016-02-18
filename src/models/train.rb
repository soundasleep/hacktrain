class Train < Pointable
  attr_reader :line, :from, :to, :name

  def initialize(x:, y:, z: 0, line:, from:, to:, name:)
    super(x: x, y: y, z: z)
    @line = line
    @from = from
    @to = to
    @name = name
  end

  def as_geometry(asset_manager)
    Node::Train.new(self, asset_manager).as_geometry
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
