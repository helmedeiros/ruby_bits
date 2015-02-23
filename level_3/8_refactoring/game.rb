class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at
  def initialize(name, options={})
    self.name = name
    self.year = options[:year]
    self.system = options[:system]
    @created_at = Time.now
  end

  def to_s
    description
  end

  def description
    "#{self.name} was released in #{self.year}."
  end
end

class ConsoleGame < Game
  def to_s
    description
  end

  def description
    "#{self.name} - #{self.system} was released in #{self.year}."
  end
end

fifa2014 = ConsoleGame.new('Fifa', year: 2014, system: 'PS3')
puts fifa2014
