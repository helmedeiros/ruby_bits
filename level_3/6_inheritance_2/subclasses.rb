class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at

  def initialize(name, options={})
    self.name = name
    self.year = options[:year]
    self.system = options[:system]
    @created_at = Time.now
  end
end

class ArcadeGame < Game
  attr_accessor :weight
  def initialize(name, options={})
    self.weight = options[:weight]
    super
  end

  def format
    [self.name, self.year, self.weight, self.system].compact.join(', ')
  end
end
class ConsoleGame < Game
end

ddr = ArcadeGame.new('Dance Dance Revolution', year: 1998, weight: 800, system: 'Bemani System 573 Analog')
puts ddr.format
