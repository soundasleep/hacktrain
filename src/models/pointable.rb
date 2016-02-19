class Pointable
  include Geometryable

  attr_reader :id, :x, :y, :z

  def initialize(id:, x:, y:, z: 0)
    @id = id
    @x = x
    @y = y
    @z = z
  end

  def point
    Vector3f.new(x, y, z)
  end
end
