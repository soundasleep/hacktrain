class Station < Pointable
  def possible_destinations(world)
    world.lines.select { |line| line.from == self }.map(&:to)
  end
end
