require 'rubygems'
require 'active_support/all'
require 'jmonkeyengine'

class Inputs; end
class Nodes; end

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

def textured_material(diffuse_map, normal_map, asset_manager)
  material = coloured_material(ColorRGBA::White, asset_manager)

  # TODO might want to cache the load_textures
  material.set_texture "DiffuseMap", asset_manager.load_texture(diffuse_map)
  material.set_texture "NormalMap", asset_manager.load_texture(normal_map) if normal_map
  material.set_float "Shininess", 64    # [0..128]

  material
end
