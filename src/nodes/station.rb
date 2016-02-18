class Node::Station < Node::RenderedNode
  def station
    object
  end

  def root_geometry
    box = Box.new(Vector3f::ZERO, 0.6, 0.1, 0.2)

    geo = Geometry.new("Box", box)
    geo.material = coloured_material(ColorRGBA::Blue, asset_manager)
    geo
  end
end
