class Communication
  def self.greeting
    "Welcome to MASTERMIND!".center(60, '*') + "\n\n"
  end

  def self.instructions
    "Mastermind is a game that asks the user to guess a secret code via keyboard input.
Please make complete selections using only the first letter of the color you're guessing.
For example, if you are guessing (r)ed, (r)ed, (g)reen, and (b)lue, you would enter: 'rrgb'.
Additionally, the game will track your number of guesses and amount of time taken.\n\n"
  end

  def self.difficulty
    "Please select a difficulty level (b), (i), or (a):
- (b)eginner: 4 characters, 4 colors
- (i)ntermediate: 6 characters, 5 colors
- (a)dvanced: 8 characters, 6 colors"
  end

  def self.game_specifics(difficulty, num_elements, colors)
    "I have generated a #{difficulty} sequence with #{num_elements} elements made up of:
#{colors}.

Use (q)uit at any time to end the game.\n\n"
  end

  def self.invalid_choice
    "Please enter a valid selection.\n\n"
  end

  def self.beginner_colors
    "(r)ed, (g)reen, (b)lue, and (y)ellow"
  end

  def self.intermediate_colors
    beginner_colors.sub("and ", '') + ", and (p)urple"
  end

  def self.advanced_colors
    intermediate_colors.sub("and ", '') + ", and (o)range"
  end

  def self.goodbye
    "Thanks for playing! Goodbye."
  end

  def self.congratulations(solution, num_guesses, time)
    "\nCongratulations!! You guessed the sequence '#{solution.upcase}' in \
#{num_guesses} guesses over #{time / 60} minutes and #{time % 60} seconds.

Do you want to (p)lay again or (q)uit?"
  end

end
