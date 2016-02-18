class Inputs
end

class Inputs::Camera
  include com.jme3.input.controls.AnalogListener
  include com.jme3.input.controls.ActionListener

  class InputError < StandardError; end

  attr_reader :app
  attr_reader :shift

  def initialize(app)
    @app = app
  end

  def mappings
    {
      "camera left": KeyTrigger.new(KeyInput.KEY_A),
      "camera right": KeyTrigger.new(KeyInput.KEY_D),
      "camera up": KeyTrigger.new(KeyInput.KEY_W),
      "camera down": KeyTrigger.new(KeyInput.KEY_S),

      "shift": KeyTrigger.new(KeyInput.KEY_LSHIFT),
    }
  end

  def onAnalog(name, value, tpf)
    if shift
      case name
        when "camera left"
          app.cam.location = app.cam.location.add(Vector3f.new(-speed * value, 0, 0))
        when "camera right"
          app.cam.location = app.cam.location.add(Vector3f.new(speed * value, 0, 0))
        when "camera up"
          app.cam.location = app.cam.location.add(Vector3f.new(0, speed * value, 0))
        when "camera down"
          app.cam.location = app.cam.location.add(Vector3f.new(0, -speed * value, 0))
      end
    end
  end

  def onAction(name, pressed, tpf)
    case name
      when "shift"
        @shift = pressed

        app.flyCam.enabled = pressed
    end
  end

  def speed
    10
  end
end
