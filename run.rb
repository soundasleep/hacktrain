# require 'java'
# require 'jruby/core_ext'

jmonkeyengine_path = File.dirname(`gem which jmonkeyengine`)

Dir[File.join(jmonkeyengine_path, "..", "vendor", "*.jar")].each do |jar|
  $CLASSPATH << jar
end

puts "#{jmonkeyengine_path}"
puts $CLASSPATH

# require 'jmonkeyengine'
#r equire 'jmonkeyengine/testdata'

# # Load JME AppSettings for setting things like resolution, fullscreen, and title
# java_import "com.jme3.system.AppSettings"
# app_settings = AppSettings.new(true)
# app_settings.title = "My game"
# app_settings.fullscreen = true
# app_settings.set_resolution(1024, 768) #old school resolution
# MyGame.settings = app_settings

# # Add in some colors

java_import "com.jme3.app.SimpleApplication"
java_import "com.jme3.material.Material"
java_import "com.jme3.math.Vector3f"
java_import "com.jme3.scene.Geometry"
java_import "com.jme3.scene.shape.Box"
java_import "com.jme3.math.ColorRGBA"
java_import "com.jme3.scene.Node"
java_import "com.jme3.system.NanoTimer"
java_import "com.jme3.scene.shape.Line"
java_import "com.jme3.light.DirectionalLight"

class TrainWorld
  attr_reader :trains
  attr_reader :stations
  attr_reader :lines

  def initialize
    @stations = []
    @stations << Station.new(x: 0, y: 3)
    @stations << Station.new(x: 9, y: 3)

    @lines = []
    @lines << TrainLine.new(start: @stations.first, finish: @stations.last)

    @trains = []
    @trains << Train.new(x: 3, y: 3, line: @lines.first, from: @stations.first, to: @stations.last)
  end
end

class Pointable
  attr_reader :x, :y, :z

  def initialize(x:, y:, z: 0)
    @x = x
    @y = y
    @z = z
  end

  def point
    Vector3f.new(x, y, z)
  end
end

def coloured_material(color, asset_manager)
  material = Material.new(asset_manager, File.join('Common', 'MatDefs', 'Light', 'Lighting.j3md'))
  material.set_boolean "UseMaterialColors", true
  material.set_color "Ambient", color
  material.set_color "Diffuse", color
  material
end

class Lineable
  attr_reader :start, :finish

  def initialize(start:, finish:)
    @start = start
    @finish = finish
  end
end

class Station < Pointable
  def as_geometry(asset_manager)
    box = Box.new(point, 0.6, 0.1, 0.2)

    geo = Geometry.new("Box", box)
    geo.material = coloured_material(ColorRGBA::Blue, asset_manager)
    geo
  end
end

class TrainLine < Lineable
  def as_geometry(asset_manager)
    line = Line.new(start.point, finish.point)
    line.set_line_width 2

    geo = Geometry.new("Line", line)
    material = Material.new(asset_manager, File.join('Common', 'MatDefs', 'Misc', 'Unshaded.j3md'))
    material.set_color("Color", ColorRGBA::Orange)
    geo.material = material
    geo
  end
end

class Train < Pointable
  attr_reader :line, :from, :to

  def initialize(x:, y:, z: 0, line:, from:, to:)
    super(x: x, y: y, z: z)
    @line = line
    @from = from
    @to = to
  end

  def as_geometry(asset_manager)
    box = Box.new(point, 0.3, 0.3, 0.3)

    geo = Geometry.new("Box", box)
    geo.material = coloured_material(ColorRGBA::Red, asset_manager)
    geo
  end

  def simpleUpdate(tpf)
    @x += tpf * dx
    @y += tpf * dy
    @z += tpf * dz
  end

  def dx
    return 0 if x == to.x
    x < to.x ? 1 : -1
  end

  def dy
    return 0 if y == to.y
    y < to.y ? 1 : -1
  end

  def dz
    return 0 if z == to.z
    z < to.z ? 1 : -1
  end
end

class Sample1 < SimpleApplication

  def simpleInitApp
    # timer = NanoTimer.new #required for patch

    box1 = Box.new(Vector3f.new(1,-1,1), 1, 1, 1)
    blue = Geometry.new("Box", box1)
    material1 = Material.new(asset_manager, File.join('Common', 'MatDefs', 'Misc', 'Unshaded.j3md'))
    material1.set_color("Color", ColorRGBA::Blue)
    blue.material = material1
    @box1 = box1

    box2 = Box.new(Vector3f.new(1,3,1), 1, 1, 1)
    red = Geometry.new("Box", box2)
    material2 = Material.new(asset_manager, File.join('Common', 'MatDefs', 'Misc', 'Unshaded.j3md'))
    material2.set_color("Color", ColorRGBA::Red)
    red.material = material2

    mesh = Box.new(Vector3f::ZERO, 1, 1, 1)
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

    getViewPort().background_color = ColorRGBA::Green

    @train_root = Node.new("train root")
    root_node.attach_child @train_root

    sun = DirectionalLight.new
    sun.set_color ColorRGBA::White
    sun.set_direction Vector3f.new(-0.5, -0.5, -0.5).normalize_local
    root_node.add_light sun

    @world = TrainWorld.new

    redrawAll
  end

  def simpleUpdate(tpf)
    @pivot.rotate(0, 2 * tpf, 0)

    @world.trains.each do |object|
      object.simpleUpdate tpf
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

java_import "com.jme3.system.AppSettings"
app_settings = AppSettings.new(true)
app_settings.title = "My game"
# app_settings.fullscreen = true
app_settings.set_resolution(800, 600) #old school resolution
# Sample1.settings = app_settings

app = Sample1.new
app.settings = app_settings
app.setShowSettings(false)
app.start



