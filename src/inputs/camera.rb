class Inputs::Camera < Inputs::AbstractInput
  include com.jme3.input.controls.AnalogListener
  include com.jme3.input.controls.ActionListener

  attr_reader :shift

  def key_mappings
    {
      "camera left": "A",
      "camera right": "D",
      "camera up": "W",
      "camera down": "S",

      "shift": "LSHIFT",
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
