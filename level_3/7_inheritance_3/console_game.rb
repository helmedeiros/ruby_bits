class Game
  attr_accessor :name, :year, :system, :created_at

  def initialize(name, options={})
    self.name = name
    self.year = options[:year]
    self.system = options[:system]
    self.created_at = Time.now
  end

  def to_s
    self.name
  end
end

class ArcadeGame < Game
  attr_accessor :weight
  def initialize(name, options={})
    super
    self.weight = options[:weight]
  end
end

class ConsoleGame < Game
  def to_s
    "#{super} #{self.system}"
  end
end

fifa2014 = ConsoleGame.new('Fifa', year: 2014, system: 'PS3')
puts fifa2014
