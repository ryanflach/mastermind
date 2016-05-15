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
    menu_check(choice)
  end

  def menu_check(input)
    if input == 'p' || input == "play"
      choose_difficulty
    elsif input == 'i' || input == "instructions"
      instructions
    elsif input == 'q' || input == "quit"
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
    difficulty_check(difficulty)
  end

  def difficulty_check(input)
    if input == 'b' || input == 'beginner'
      beginner_game
    elsif input == 'i' || input == 'intermediate'
      intermediate_game
    elsif input == 'a' || input == 'advanced'
      advanced_game
    else
      menu_check(input)
    end
  end

  def beginner_game
    @gameplay = Gameplay.new(4, 4)
    game_start("beginner", 4, Communication.beginner_colors)
  end

  def intermediate_game
    @gameplay = Gameplay.new(6, 5)
    game_start("intermediate", 6, Communication.intermediate_colors)
  end

  def advanced_game
    @gameplay = Gameplay.new(8, 6)
    game_start("advanced", 8, Communication.advanced_colors)
  end

  def game_start(difficulty, num_characters, colors)
    puts Communication.game_specifics(difficulty, num_characters, colors)
    gameplay.start_clock
    gameplay.guessing(num_characters)
  end

end
