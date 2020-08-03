class Knight
	attr_accessor :parent, :children
	attr_reader :position

	def initialize(position, parent=nil)
		@position = position
		@parent = parent
		@children = []
	end
end

class Move
	def moves(position)
    
    posible_moves = []
    posible_moves.push(
      [position[0] + 2, position[1] + 1],
      [position[0] + 2, position[1] - 1],
      [position[0] - 2, position[1] + 1],
      [position[0] - 2, position[1] - 1],
      [position[0] + 1, position[1] + 2],
      [position[0] + 1, position[1] - 2],
      [position[0] - 1, position[1] + 2],
      [position[0] - 1, position[1] - 2]
      )

      posible_moves = posible_moves.select {|move|
        move[0].between?(0,7) && move[1].between?(0,7)
      }
      posible_moves
  end

  def bfs(knight, target)
  	queue = [knight]

  	until queue.empty?
  		current = queue.shift
  		return current if current.position == target
  		queue += current.children
  	end
  end

  def knight_moves(start, target)
  	positions_arr = [start]
  	knight_start_point = Knight.new(start)
  	queue = [knight_start_point]

  	until positions_arr.include?(target)
  		current = queue.shift
  		possible_moves = moves(current.position)

  		possible_moves.each do |move|
  			unless positions_arr.include?(move)
  				positions_arr << move
  				next_position = Knight.new(move, current)
  				current.children << next_position
  				queue << next_position
  			end
  		end

  	end
  	history = []

  	knight = bfs(knight_start_point, target)

  	until knight.parent.nil?
  		history.unshift(knight.position)
  		knight = knight.parent
  	end

  	history.unshift(start)

  	output = "Got there in #{(history.length - 1)} moves. Path: "
  	puts output

  	history.each do |move|
  		puts move.to_s
  	end
  	
  end
end

move = Move.new

move.knight_moves([3,3],[4,3])
