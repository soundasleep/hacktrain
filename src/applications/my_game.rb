class MyGame < SimpleApplication

  def simpleInitApp
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

    redrawAll
  end

  def simpleUpdate(tpf)
    @pivot.rotate(0, 2 * tpf, 0)

    @world.trains.each do |object|
      object.simpleUpdate @world, tpf
    end

    redrawAll
  end

  def redrawAll
    @train_root.detach_all_children

    @world.stations.each do |object|
      @train_root.attach_child object.as_geometry(asset_manager)
    end

    @world.lines.each do |object|
      @train_root.attach_child object.as_geometry(asset_manager)
    end

    @world.trains.each do |object|
      @train_root.attach_child object.as_geometry(asset_manager)
    end
  end
end
