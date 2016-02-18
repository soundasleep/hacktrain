class TrainWorld
  attr_reader :trains
  attr_reader :stations
  attr_reader :lines

  RANDOM_STATIONS = 15
  RANDOM_TRAINS = 4
  RANDOM_LINES = (RANDOM_STATIONS * 1.1).to_i

  def initialize
    @stations = []
    @lines = []
    @trains = []

    # add some random stations
    RANDOM_STATIONS.times do
      @stations << Station.new(x: rand(25) - 12, y: rand(15) - 7)
    end

    # add some random lines
    RANDOM_LINES.times do
      a = @stations.sample
      b = (@stations - [a]).sample
      @lines << TrainLine.new(from: a, to: b)
      @lines << TrainLine.new(from: b, to: a)
    end

    # add some random trains
    RANDOM_TRAINS.times do |n|
      line = @lines.sample
      @trains << Train.new(x: line.from.x, y: line.from.y, line: line, from: line.from, to: line.to, name: "Train #{n + 1}")
    end
  end
end
