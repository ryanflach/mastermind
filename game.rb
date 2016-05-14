require_relative 'communication'
require_relative 'gameplay'

class Game
  attr_reader :gameplay

  def initialize
    puts Communication.greeting
    game_menu
  end

  def game_menu
    puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    choice = gets.chomp.downcase
    if choice == 'p' || choice == "play"
      choose_difficulty
    elsif choice == 'i' || choice == "instructions"
      instructions
    elsif choice == 'q' || choice == "quit"
      puts Communication.goodbye
    else
      puts Communication.invalid_choice
      game_menu
    end
  end

  def instructions
    puts Communication.instructions
    sleep(1.5)
    game_menu
  end

  def choose_difficulty
    puts Communication.difficulty
    difficulty = gets.chomp.downcase
    if difficulty == 'b' || difficulty == 'beginner'
      @gameplay = Gameplay.new(4, 4)
      game_start("beginner", 4, Communication.beginner_colors)
    elsif difficulty == 'i' || difficulty == 'intermediate'
      @gameplay = Gameplay.new(6, 5)
      game_start("intermediate", 6, Communication.intermediate_colors)
    elsif difficulty == 'a' || difficulty == 'advanced'
      @gameplay = Gameplay.new(8, 6)
      game_start("advanced", 8, Communication.advanced_colors)
    else
      puts Communication.invalid_choice
      choose_difficulty
    end
  end

  def game_start(difficulty, num_characters, colors)
    puts Communication.game_specifics(difficulty, num_characters, colors)
    gameplay.start_clock
    gameplay.guessing(num_characters)
  end

end
