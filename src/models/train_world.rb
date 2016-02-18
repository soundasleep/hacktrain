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