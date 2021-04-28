class Park
  attr_reader :name, :trails, :visitors
  def initialize(name)
    @name = name
    @trails = []
    @visitors = Hash.new([])
  end

  def add_trail(trail)
    @trails << trail
  end

  def trails_shorter_than(length)
    @trails.find_all do |trail|
      trail.length < length
    end
  end

  def hikeable_miles
    @trails.sum do |trail|
      trail.length
    end
  end

  def trails_by_level
    trail_level = Hash.new([])
    @trails.each do |trail|
      if trail_level[trail.level].empty?
        trail_level[trail.level] = [trail.name]
      else
        trail_level[trail.level] << trail.name
      end
    end
    trail_level
  end

  def visitor(visitor)
    if @visitors[Time.now].empty?
      @visitors[Time.now] = [visitor]
    else
      @visitors[Time.now] << visitor
    end
  end

  def visitors_log
    require 'pry'; binding.pry
  end
end