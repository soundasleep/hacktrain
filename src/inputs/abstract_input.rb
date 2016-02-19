class Inputs::AbstractInput
  include com.jme3.input.controls.ActionListener

  attr_reader :app

  def initialize(app)
    @app = app
  end

  def key_mappings
    []
  end

  def mouse_mappings
    []
  end
end
