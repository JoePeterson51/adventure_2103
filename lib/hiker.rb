class Hiker
  attr_reader :name, :experience_level, :snacks, :parks_visited
  def initialize(name, experience_level)
    @name = name
    @experience_level = experience_level
    @snacks = Hash.new(0)
    @parks_visited = []
  end

  def pack(snack, quantity)
    @snacks[snack] += quantity
  end

  def visit(park)
    @parks_visited << park
    park.visitor(self)
  end

  def park_trails
    @parks_visited.flat_map do |park|
      park.trails
    end
  end

  def possible_trails
    park_trails.find_all do |trail|
      trail.level == @experience_level
    end
  end

  def favorite_snack
    favorite = @snacks.max_by do |snack|
      snack[1]
    end
    favorite[0]
  end
end