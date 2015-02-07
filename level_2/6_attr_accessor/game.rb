class Game
  def initialize(name, options={})
    @name = name
    @year = options[:year]
    @system = options[:system]
  end

  def name
    @name
  end

  def year
    @year
  end

  def system
    @system
  end
end
