# game.rb
class DungeonGame
  def initialize(width = 25, height = 10)
    @width = width
    @height = height
    @player = { x: 1, y: 1 }
    @exit = { x: width - 2, y: height - 2 }
    @running = true
  end

  # Clears the terminal and draws the current game state
  def render
    system("clear") || system("cls")
    puts "--- RUBY DUNGEON CRAWLER ---"
    puts "Controls: W (Up), A (Left), S (Down), D (Right) | Q to Quit"
    
    @height.times do |y|
      row = ""
      @width.times do |x|
        if x == @player[:x] && y == @player[:y]
          row += " @ " # Player character
        elsif x == @exit[:x] && y == @exit[:y]
          row += " E " # Exit door
        elsif x == 0 || x == @width - 1 || y == 0 || y == @height - 1
          row += " # " # Boundary walls
        else
          row += " . " # Open floor
        end
      end
      puts row
    end
  end

  def update_position(input)
    new_x, new_y = @player[:x], @player[:y]
    
    case input.downcase
    when 'w' then new_y -= 1
    when 's' then new_y += 1
    when 'a' then new_x -= 1
    when 'd' then new_x += 1
    when 'q' then @running = false
    end

    # Boundary Collision Detection
    unless new_x <= 0 || new_x >= @width - 1 || new_y <= 0 || new_y >= @height - 1
      @player[:x] = new_x
      @player[:y] = new_y
    end
  end

  def check_status
    if @player == @exit
      render
      puts "\n✨ CONGRATULATIONS! You found the exit. ✨"
      @running = false
    end
  end

  def play
    while @running
      render
      print "\nNext move: "
      input = gets.chomp
      update_position(input)
      check_status
    end
  end
end

# Entry point for the game
if __FILE__ == $0
  game = DungeonGame.new
  game.play
end