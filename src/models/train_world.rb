class TrainWorld
  attr_reader :trains
  attr_reader :stations
  attr_reader :lines

  RANDOM_STATIONS = 15
  RANDOM_TRAINS = 4
  RANDOM_LINES = (RANDOM_STATIONS * 0.1).to_i

  def initialize
    @stations = []
    @lines = []
    @trains = []

    # add some random stations
    RANDOM_STATIONS.times do |i|
      @stations << Station.new(id: i, x: rand(25.0) - 12, y: rand(15.0) - 7)
    end

    # add some random lines
    RANDOM_LINES.times do |i|
      a = @stations.sample
      b = (@stations - [a]).sample
      @lines << TrainLine.new(from: a, to: b)
      @lines << TrainLine.new(from: b, to: a)
    end

    # add some random trains
    RANDOM_TRAINS.times do |i|
      line = @lines.sample
      @trains << Train.new(id: i, x: line.from.x, y: line.from.y, line: line, from: line.from, to: line.to, name: "Train #{i + 1}")
    end
  end
end
