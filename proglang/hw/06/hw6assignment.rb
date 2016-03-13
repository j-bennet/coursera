# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyTetris < Tetris

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end
  
  alias_method :key_bindings_parent, :key_bindings
  
  def key_bindings
    key_bindings_parent
    @root.bind('u', proc { @board.rotate_180 }) 
    @root.bind('c', proc { @board.cheat(self) }) 
  end

end

class MyPiece < Piece

  @@cheating = false
  
  # class method to choose the next piece
  def self.next_piece (board)
    if (@@cheating)
	  @@cheating = false
      MyPiece.new(Cheat_Piece, board)
	else
      MyPiece.new(All_My_Pieces.sample, board)
	end
  end
  
  def self.cheat
    @@cheating = true
  end
  
  def self.cheating
	@@cheating
  end

  # The constant All_My_Pieces should be declared here
  All_My_Pieces = All_Pieces + [rotations([[0, 0], [-1, 0], [0, 1], [-1, 1], [1, 1]]), # square + 1
                   [[[0, 0], [-1, 0], [-2, 0], [1, 0], [2, 0]], [[0, 0], [0, -1], [0, -2], [0, 1], [0, 2]]],
                   rotations([[0, 0], [0, 1], [1, 1]])] # L
				   
  Cheat_Piece = [[[0, 0]]]
  
end

class MyBoard < Board
  
  def initialize (game)
    @grid = Array.new(num_rows) { Array.new(num_columns) }
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
	@cheat_piece = nil
  end
  
  # gets the next piece
  def next_piece
    @current_block = MyPiece.next_piece(self)
    @current_pos = nil
  end
  
  # next piece will be a cheat piece
  def cheat (game)
	if ((@score >= 100) and (!MyPiece.cheating))
		@score -= 100
		game.update_score
		MyPiece.cheat
	end
  end
  
  # gets the information from the current piece about where it is and uses this
  # to store the piece on the board itself.  Then calls remove_filled.
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    locations.each_index{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end
  
  # rotate 180 degrees
  def rotate_180
    rotate_clockwise
    rotate_clockwise
  end

end
