require_relative 'communication'
require_relative 'solution_generator'
require_relative 'game'

class Gameplay
  attr_reader :guess,
              :solution,
              :number_of_guesses,
              :start_time,
              :correct_position,
              :correct_element

  def initialize(num_characters, num_colors)
    @solution = SolutionGenerator.key_maker(num_characters, num_colors)
    @number_of_guesses = 0
    @start_time = nil
  end

  def start_clock
    @start_time = Time.now
  end

  def guessing(num_characters)
    puts "What's your guess?"
    @guess = gets.chomp.downcase
    response_check(guess, num_characters)
  end

  def response_check(input, num_characters)
    if input == 'c' || input == "cheat"
      puts "The current secret code is: '#{solution.upcase}'. Cheater!"
      end_game
    elsif input == 'q' || input == "quit"
      puts Communication.goodbye
      exit
    else
      length_check(input, num_characters)
    end
  end

  def length_check(input, num_characters)
    if input.length > num_characters
      puts "Your guess is too long. Please guess #{num_characters} characters only."
      guessing(num_characters)
    elsif input.length < num_characters
      puts "Your guess is too short. Please guess #{num_characters} characters only."
      guessing(num_characters)
    else
      solution_check(input, num_characters)
    end
  end

  def solution_check(input, num_characters)
    if input == solution
      @number_of_guesses += 1
      end_game
    else
      @number_of_guesses += 1
      guess_check
      guessing(num_characters)
    end
  end

  def guess_check
    check_position
    check_element
    puts "'#{guess.upcase}' has #{correct_element} of the correct elements with #{correct_position} in the correct position(s)."
    if number_of_guesses == 1
      puts "You've taken #{number_of_guesses} guess."
    else
      puts "You've taken #{number_of_guesses} guesses."
    end
  end

  def check_position
    @correct_position = 0
    0.upto(guess.length - 1) do |index|
      @correct_position += 1 if guess[index] == solution[index]
    end
  end

  def check_element
    @correct_element = 0
    modified_solution = solution.dup
    modified_guess = guess.dup
    0.upto(guess.length - 1) do |index|
      modified_guess.each_char do |char|
        if char == modified_solution[index]
          modified_solution.sub!(modified_solution[index], 'æ')
          modified_guess.sub!(char, '-')
          @correct_element += 1
        end
      end
    end
  end

  def play_or_quit(input)
    if input == 'q' || input == "quit"
      puts Communication.goodbye
    elsif input == 'p' || input == "play"
      puts "Playing again!\n\n"
      Game.new
    end
  end

  def end_game
    end_time = Time.now
    final_time = (end_time - start_time).to_i
    puts Communication.congratulations(solution.upcase, number_of_guesses, final_time)
    response = gets.chomp.downcase
    play_or_quit(response)
  end

end
