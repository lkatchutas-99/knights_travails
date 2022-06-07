
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
    # coordinates
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
    create_children_squares(square, position)
  end

  # set current square's children
  def create_children_squares(square, position)
    square.up_right = validate(square, position, @moves[:up_right])
    square.right_up = validate(square, position, @moves[:right_up])
    square.right_down = validate(square, position, @moves[:right_down])
    square.down_right = validate(square, position, @moves[:down_right])
    square.down_left = validate(square, position, @moves[:down_left])
    square.left_down = validate(square, position, @moves[:left_down])
    square.left_up = validate(square, position, @moves[:left_up])
    square.up_left = validate(square, position, @moves[:up_left])
    square
  end

  # check if square meets validation
  def validate(parent, position, moves)
    position = position.map.with_index { |coordinate, idx| coordinate + moves[idx] }
    return unless position.all? { |coordinate| coordinate >= 0 && coordinate <= 7 }
    
    square = Square.new(position)
    square.parent = parent
    square
  end

  # move knight to new location
  def move_knight(new_location)
    current_square = @root
    print_path(bfs(current_square, new_location))
  end

  # level order search
  def bfs(current_square, new_location)
    queue = []
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
    current_square
  end

  # print path between origin and destination
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