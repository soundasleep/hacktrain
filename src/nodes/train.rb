class Node::Train
  attr_reader :train, :asset_manager

  delegate :name, to: :train

  def initialize(train, asset_manager)
    @train = train
    @asset_manager = asset_manager
  end

  def as_geometry
    box = Box.new(Vector3f::ZERO, 0.3, 0.3, 0.3)

    geo = Geometry.new("Box", box)
    geo.material = coloured_material(ColorRGBA::Red, asset_manager)
    geo

    guiFont = asset_manager.loadFont("Interface/Fonts/Console.fnt")

    text = BitmapText.new(guiFont, false)
    text.size = 0.3
    text.color = ColorRGBA::White
    text.text = "#{name}"
    text.set_local_translation -text.getLineWidth() / 2, text.getLineHeight() / 2, 0.35
    text.queue_bucket = RenderQueue::Bucket::Transparent

    node = Node.new("train node #{name}")
    node.attach_child geo
    node.attach_child text
    node
  end
end
