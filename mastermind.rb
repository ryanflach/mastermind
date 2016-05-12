def setup
  welcome_message = "Welcome to MASTERMIND!"
  puts welcome_message.center(welcome_message.length + 40, '*')
  puts ""
  @number_of_guesses = 0
end

def key_maker(characters, colors)
  base_colors = ['r','g','b','y']
  intermediate_colors = base_colors.dup << 'p'
  advanced_colors = intermediate_colors.dup << 'o'
  available_colors = []
  game_colors = []

  if colors == 4
    available_colors = base_colors
  elsif colors == 5
    available_colors = intermediate_colors
  else
    available_colors = advanced_colors
  end

  characters.times do
    game_colors << available_colors.sample
  end
  @solution = game_colors.join
end

def game_start
  puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
  choice = gets.chomp.downcase
  if choice == 'p' || choice == "play"
    play
  elsif choice == 'i' || choice == "instructions"
    instructions
  elsif choice == 'q' || choice == "quit"
    puts "Goodbye."
  else
    puts "Please enter a valid choice."
    game_start
  end
end

def instructions
  puts "Mastermind is a game that asks the user to guess a secret code via keyboard input.
Please make complete selections using only the first letter of the color you're guessing.
For example, if you are guessing (r)ed, (r)ed, (g)reen, and (b)lue, you would enter: 'rrgb'.
Additionally, the game will track your number of guesses and amount of time taken."
  sleep(1.5)
  puts ""
  game_start
end

def message(difficulty, num_elements, colors)
  "I have generated a #{difficulty} sequence with #{num_elements} elements made up of:
#{colors}.

Use (q)uit at any time to end the game.\n\n"

end

def play
  puts "Please select a difficulty level (b), (i), or (a):
- (b)eginner: 4 characters, 4 colors
- (i)ntermediate: 6 characters, 5 colors
- (a)dvanced: 8 characters, 6 colors"

  difficulty = gets.chomp.downcase
  beginner_colors = "(r)ed, (g)reen, (b)lue, and (y)ellow"
  intermediate_colors = beginner_colors.sub("and ", '') + ", and (p)urple"
  advanced_colors = intermediate_colors.sub("and ", '') + ", and (o)range"

  if difficulty == 'b' || difficulty == 'beginner'
    @characters = 4
    puts message("beginner", @characters, beginner_colors)
    key_maker(@characters, 4)
  elsif difficulty == 'i' || difficulty == 'intermediate'
    @characters = 6
    puts message("intermediate", @characters, intermediate_colors)
    key_maker(@characters, 5)
  elsif difficulty == 'a' || difficulty == 'advanced'
    @characters = 8
    puts message("advanced", @characters, advanced_colors)
    key_maker(@characters, 6)
  else
    puts "Please enter a valid selection."
    play
  end

  @start_time = Time.now
  guessing(@characters)
end

def guessing(num_characters)
  puts "What's your guess?"
  @guess = gets.chomp.downcase
  if @guess == 'q' || @guess == "quit"
    puts "Goodbye."
  elsif @guess == 'c' || @guess == "cheat"
    puts "The current secret code is '#{@solution.upcase}'. Cheater."
    game_start
  elsif @guess.length != @characters
    puts "Please guess #{@characters} characters only."
    guessing(@characters)
  elsif @guess == @solution
    @number_of_guesses += 1
    end_game
  else
    @number_of_guesses += 1
    guess_check
    guessing(@characters)
  end
end

def guess_check
  correct_element = 0
  correct_position = 0
  modified_solution = @solution.dup

  0.upto(@guess.length - 1) do |index|
    correct_position += 1 if @guess[index] == @solution[index]
    @guess.each_char do |char|
      if char == modified_solution[index]
        correct_element += 1
        modified_solution.sub!(modified_solution[index], '-')
      end
    end
  end

  puts "'#{@guess.upcase}' has #{correct_element} of the correct elements with #{correct_position} in the correct position(s)."
  if @number_of_guesses == 1
    puts "You've taken #{@number_of_guesses} guess."
  else
    puts "You've taken #{@number_of_guesses} guesses."
  end
end

def end_game
  end_time = Time.now
  final_time = (end_time - @start_time).to_i
  puts "Congratulations! You guessed the sequence '#{@solution.upcase}' in \
#{@number_of_guesses} guesses over #{final_time / 60} minutes and #{final_time % 60} seconds."
end

setup
game_start
