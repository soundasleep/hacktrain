class TrainLine < Lineable
  def as_geometry(asset_manager, state)
    line = Line.new(from.point, to.point)
    line.set_line_width 2

    geo = Geometry.new("Line", line)
    material = Material.new(asset_manager, File.join('Common', 'MatDefs', 'Misc', 'Unshaded.j3md'))
    material.set_color("Color", ColorRGBA::Orange)
    geo.material = material
    geo
  end
end
