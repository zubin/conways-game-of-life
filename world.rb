require 'set'
class World
  def initialize
    @cells = Set.new
  end

  def add(x,y)
    @cells << {x: x, y: y}
  end
  
  def active_at?(x,y)
    @cells.any? { |cell| cell[:x] == x and cell[:y] == y }
  end
  
  def tick
    @cells = cells_which_stay_alive + revived_cells
  end

  private

  def cells_which_stay_alive
    @cells.select { |cell| (2..3).include?(num_neighbours(cell[:x], cell[:y])) }
  end
  
  def num_neighbours(cell_x,cell_y)
    x_values = *((cell_x-1)..(cell_x + 1))
    y_values = *((cell_y-1)..(cell_y + 1))
    x_values.product(y_values).select do |x,y|
      active_at?(x,y) unless x == cell_x and y == cell_y
    end.compact.length
  end
  
  def revived_cells
    sorted_by_x = @cells.sort_by { |cell| cell[:x] }
    sorted_by_y = @cells.sort_by { |cell| cell[:y] }
    lowest_x    = sorted_by_x.first[:x] - 1 
    highest_x   = sorted_by_x.last[:x] + 1
    lowest_y    = sorted_by_x.first[:y] - 1
    highest_y   = sorted_by_x.last[:y] + 1
    x_values    = *(lowest_x..highest_x)
    y_values    = *(lowest_y..highest_y)
    x_values.product(y_values).select do |x,y|
      num_neighbours(x,y) == 3
    end.compact.collect do |x,y|
      {:x => x, :y => y}
    end
  end
end
