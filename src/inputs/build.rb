class Inputs::Build < Inputs::AbstractInput
  include com.jme3.input.controls.ActionListener

  attr_reader :selected

  def key_mappings
    {
      "toggle build line": "B",
    }
  end

  def mouse_mappings
    {
      "build select": "LEFT",
    }
  end

  def onAction(name, pressed, tpf)
    if pressed
      case name
        when "toggle build line"
          app.state[:build] = !app.state[:build]
          puts "build set to #{app.state[:build]}"

        when "build select"
          if build_state?
            hovered = currently_hovered_station

            if selected
              # build a line
              if hovered
                if selected != hovered
                  build_line!(selected, hovered)
                  @selected = nil
                  app.select(@selected)
                end
              end
            else
              # select the current thing
              if currently_hovered_station
                @selected = currently_hovered_station
                app.select(@selected)
              end
            end
          end
      end
    end
  end

  private

  def build_state?
    app.state[:build]
  end

  def currently_hovered_station
    app.collide_with_pointer.select { |s| s.is_a?(Station) }.first
  end

  def build_line!(from, to)
    app.build_line!(from, to)
    app.build_line!(to, from)

    puts "Built line between #{from.name} <-> #{to.name}"
  end
end
