class MyGame < SimpleApplication
  field_accessor :cam, :flyCam

  attr_reader :state

  def simpleInitApp
    @state = {
      build: false,
      debug: false,
    }

    # timer = NanoTimer.new #required for patch

    box1 = Box.new(Vector3f.new(1,-1,1), 0.1, 0.1, 0.1)
    blue = Geometry.new("Box", box1)
    material1 = Material.new(asset_manager, File.join('Common', 'MatDefs', 'Misc', 'Unshaded.j3md'))
    material1.set_color("Color", ColorRGBA::Blue)
    blue.material = material1
    @box1 = box1

    box2 = Box.new(Vector3f.new(1,3,1), 0.1, 0.1, 0.1)
    red = Geometry.new("Box", box2)
    material2 = Material.new(asset_manager, File.join('Common', 'MatDefs', 'Misc', 'Unshaded.j3md'))
    material2.set_color("Color", ColorRGBA::Red)
    red.material = material2

    mesh = Box.new(Vector3f::ZERO, 0.1, 0.1, 0.1)
    thing = Geometry.new("thing", mesh)
    mat = Material.new(asset_manager, File.join('Common', 'MatDefs', 'Misc', 'ShowNormals.j3md'))
    thing.material = mat
    root_node.attach_child(thing)

    pivot = Node.new("pivot")
    root_node.attach_child(pivot)
    pivot.attach_child(blue)
    pivot.attach_child(red)
    pivot.rotate(0.4, 0.4, 0.0)
    @pivot = pivot

    getViewPort().background_color = ColorRGBA.new(0.1, 0.1, 0.1, 1)

    @train_root = Node.new("train root")
    root_node.attach_child @train_root

    sun = DirectionalLight.new
    sun.color = ColorRGBA::White
    sun.direction = Vector3f.new(-0.5, -0.5, -0.5).normalize_local
    root_node.add_light sun

    ambient = AmbientLight.new
    ambient.color = ColorRGBA::White.mult(0.2)
    root_node.add_light ambient

    @world = TrainWorld.new

    cam.location = Vector3f.new(0, 0, 20)
    flyCam.enabled = false

    init_keys

    redraw_all
  end

  attr_reader :keys_registered

  def init_keys
    @keys_registered = []
    @mouse_registered = []

    [
      Inputs::Camera,
      Inputs::Debug,
      Inputs::Build,
    ].each do |input_class|
      input = input_class.new(self)

      input.key_mappings.each do |title, key|
        trigger = KeyTrigger.new(KeyInput.send("KEY_#{key}"))

        input_manager.add_mapping title, trigger
        input_manager.add_listener input, title

        @keys_registered << "#{key}\t#{title}"
      end

      input.mouse_mappings.each do |title, key|
        trigger = MouseButtonTrigger.new(MouseInput.send("BUTTON_#{key}"))

        input_manager.add_mapping title, trigger
        input_manager.add_listener input, title

        @mouse_registered << "#{key}\t#{title}"
      end
    end
  end

  def simpleUpdate(tpf)
    @pivot.rotate(0, 2 * tpf, 0)

    @world.trains.each do |object|
      object.simpleUpdate @world, tpf
    end

    if state[:redraw]
      redraw_all
      state[:redraw] = false
    else
      redraw_trains
    end
  end

  def train_pivot
    if @train_pivot.nil?
      @train_pivot = Node.new("train pivot")
      root_node.attach_child @train_pivot
    end
    @train_pivot
  end

  def redraw_all
    @train_root.detach_all_children

    @world.stations.each do |object|
      @train_root.attach_child wrap_node(object)
    end

    @world.lines.each do |object|
      @train_root.attach_child object.as_geometry(asset_manager, state)
    end

    redraw_trains
  end

  def redraw_trains
    train_pivot.detach_all_children

    @world.trains.each do |object|
      train_pivot.attach_child wrap_node(object)
    end
  end

  def wrap_node(object)
    geo = object.as_geometry(asset_manager, state, @selected == object)

    geo.set_user_data "type", object.class.name
    geo.set_user_data "id", object.id

    node = Node.new
    node.attach_child geo
    node.set_local_translation object.point

    node
  end

  def display_help!
    puts "Keys available:"
    puts @keys_registered

    puts "Mouse available:"
    puts @mouse_registered
  end

  def collide_with_pointer
    results = CollisionResults.new
    click2d = input_manager.get_cursor_position
    click3d = cam.get_world_coordinates(click2d, 0).clone
    direction = cam.get_world_coordinates(click2d, 1).subtract_local(click3d).normalize_local

    ray = Ray.new(click3d, direction)
    root_node.collide_with(ray, results)

    results.map do |r|
      type = r.geometry.parent.get_user_data("type")
      id = r.geometry.parent.get_user_data("id")

      case type
        when Station.name
          @world.stations
        when Train.name
          @world.trains
        else
          []
      end.select { |s| s.id == id }.first
    end.compact
  end

  def build_line!(from, to)
    @world.lines << TrainLine.new(from: from, to: to)

    @state[:redraw] = true
  end

  def select(object)
    @selected = object

    @state[:redraw] = true
  end
end
