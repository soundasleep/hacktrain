class Node::RenderedNode
  attr_reader :object, :asset_manager

  delegate :name, to: :object

  def initialize(object, asset_manager)
    @object = object
    @asset_manager = asset_manager
  end

  def as_geometry(state, selected = false)
    node = Node.new("#{self.class.name} #{name}")
    geo = root_geometry

    # change the colour if selected
    if selected
      geo.material = coloured_material(ColorRGBA::Yellow, asset_manager)
    end

    node.attach_child geo

    if state[:debug]
      guiFont = asset_manager.loadFont("Interface/Fonts/Console.fnt")

      text = BitmapText.new(guiFont, false)
      text.size = 0.3
      text.color = ColorRGBA::White
      text.text = "#{name}"
      text.set_local_translation (-text.getLineWidth() / 2), text.getLineHeight() / 2, 0.35
      text.queue_bucket = RenderQueue::Bucket::Transparent

      node.attach_child text
    end

    node
  end

  def root_geometry
    box = Box.new(Vector3f::ZERO, 0.3, 0.3, 0.3)

    geo = Geometry.new("Box", box)
    geo.material = coloured_material(ColorRGBA::Red, asset_manager)
    geo
  end
end
