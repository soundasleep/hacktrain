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

  end

  def simpleUpdate(tpf)
    @pivot.rotate(0, 2 * tpf, 0)
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



