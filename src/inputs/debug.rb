class Inputs::Debug
  include com.jme3.input.controls.ActionListener

  attr_reader :app
  attr_reader :shift

  def initialize(app)
    @app = app
  end

  def key_mappings
    {
      "display help": "F1",
      "toggle debug": "F2",
    }
  end

  def onAction(name, pressed, tpf)
    if pressed
      case name
        when "display help"
          app.display_help!

        when "toggle debug"
          app.state[:debug] = !app.state[:debug]
          app.state[:redraw] = true
      end
    end
  end
end
