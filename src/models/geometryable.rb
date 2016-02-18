module Geometryable
  def as_geometry(asset_manager, state)
    node_class.new(self, asset_manager).as_geometry(state)
  end

  def node_class
    "Node::#{self.class}".constantize
  end

  def name
    self.class.to_s
  end
end
