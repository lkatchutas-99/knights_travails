
# Square
class Square
  attr_accessor :data, :parent, :up_right, :right_up, :right_down, :down_right, :down_left, :left_down, :left_up, :up_left
  def initialize(data)
    @data = data
    @parent = parent
    @up_right = nil
    @right_up = nil
    @right_down = nil
    @down_right = nil
    @down_left = nil
    @left_down = nil
    @left_up = nil
    @up_left = nil
  end
end

class Knight
  attr_accessor :root
  def initialize(initial_position = [0, 0])
    @moves = { 
      up_right: [1, 2], 
      right_up: [2, 1],
      right_down: [2, -1],
      down_right: [1, -2],
      down_left: [-1, -2],
      left_down: [-2, -1],
      left_up: [-2, 1],
      up_left: [-1, 2]
    }

    # initialize root
    @root = create_square(initial_position, Square.new(initial_position))
  end

  # validate all moves in current square
  def create_square(position, square)

    # give coordindates to possible moves
    square.up_right = validate(position, @moves[:up_right])
    square.right_up = validate(position, @moves[:right_up])
    square.right_down = validate(position, @moves[:right_down])
    square.down_right = validate(position, @moves[:down_right])
    square.down_left = validate(position, @moves[:down_left])
    square.left_down = validate(position, @moves[:left_down])
    square.left_up = validate(position, @moves[:left_up])
    square.up_left = validate(position, @moves[:up_left])
    
    # initialize parent to each move
    square.up_right.parent = square unless square.up_right.nil?
    square.right_up.parent = square unless square.right_up.nil?
    square.right_down.parent = square unless square.right_down.nil?
    square.down_right.parent = square unless square.down_right.nil?
    square.down_left.parent = square unless square.down_left.nil?
    square.left_down.parent = square unless square.left_down.nil?
    square.left_up.parent = square unless square.left_up.nil?
    square.up_left.parent = square unless square.up_left.nil?

    square
  end


  def validate(position, moves)
    position = position.map.with_index { |coordinate, idx| coordinate + moves[idx] }
    return unless position.all? { |coordinate| coordinate >= 0 && coordinate <= 7 }
    
    Square.new(positions)
  end

  def move_knight(new_location)
    queue = []
    current_square = @root
    locations_visited = []
    current_square = bfs(current_square, queue)
    path = print_path(current_square)
    @root = current_square
    @root.parent = nil
    path
  end

  def bfs(current_square, queue)
    until current_square.data == new_location
      queue.push(current_square.up_right) unless current_square.up_right.nil?
      queue.push(current_square.right_up) unless current_square.right_up.nil?
      queue.push(current_square.right_down) unless current_square.right_down.nil?
      queue.push(current_square.down_right) unless current_square.down_right.nil?
      queue.push(current_square.down_left) unless current_square.down_left.nil?
      queue.push(current_square.left_down) unless current_square.left_down.nil?
      queue.push(current_square.left_up) unless current_square.left_up.nil?
      queue.push(current_square.up_left) unless current_square.up_left.nil?
      next_square = queue.shift
      current_square = create_square(next_square.data, next_square)
    end
  end

  def print_path(current_square)
    path = []
    until current_square.data == @root.data
      path.unshift(current_square.data)
      current_square = current_square.parent
    end
    puts "You made it in #{path.length} moves! Here's your path: "
    path.unshift(@root.data)
    path.each { |coordinate| p coordinate }
    path
  end
end

def knight_moves(from, to)
  Knight.new(from).move_knight(to)
end