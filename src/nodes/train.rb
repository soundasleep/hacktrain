class Node::Train < Node::RenderedNode
  def train
    object
  end

  def root_geometry
    box = Box.new(Vector3f::ZERO, 0.3, 0.3, 0.3)

    geo = Geometry.new("Box", box)
    geo.material = coloured_material(ColorRGBA::Red, asset_manager)
    geo
  end
end
