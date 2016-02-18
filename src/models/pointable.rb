class Pointable
  attr_reader :x, :y, :z

  def initialize(x:, y:, z: 0)
    @x = x
    @y = y
    @z = z
  end

  def point
    Vector3f.new(x, y, z)
  end
end
