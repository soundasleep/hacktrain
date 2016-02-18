class Station < Pointable
  def as_geometry(asset_manager)
    box = Box.new(point, 0.6, 0.1, 0.2)

    geo = Geometry.new("Box", box)
    geo.material = coloured_material(ColorRGBA::Blue, asset_manager)
    geo
  end

  def possible_destinations(world)
    world.lines.select { |line| line.from == self }.map(&:to)
  end
end
