class Node::WorldFloor < Node::RenderedNode
  def root_geometry
    box = Box.new(Vector3f::ZERO, 30, 30, 0.01)

    geo = Geometry.new("Box", box)
    geo.material = textured_material("Textures/Terrain/Pond/Pond.jpg", "Textures/Terrain/Pond/Pond_normal.png", asset_manager)
    geo.local_translation = Vector3f.new(0, 0, -0.02)
    geo
  end
end
