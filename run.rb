jmonkeyengine_path = File.dirname(`gem which jmonkeyengine`)

Dir[File.join(jmonkeyengine_path, "..", "vendor", "*.jar")].each do |jar|
  $CLASSPATH << jar
end

Dir[File.dirname(__FILE__) + '/src/**/*.rb'].each do |file|
  require file
end

# debug information
puts "Classpath: "
$CLASSPATH.each do |path|
  puts "  #{path}"
end

start_app

def coloured_material(color, asset_manager)
  material = Material.new(asset_manager, File.join('Common', 'MatDefs', 'Light', 'Lighting.j3md'))
  material.set_boolean "UseMaterialColors", true
  material.set_color "Ambient", color
  material.set_color "Diffuse", color
  material
end
