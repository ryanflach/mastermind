class SolutionGenerator

  def self.key_maker(characters, num_colors)
    base_colors = ['r','g','b','y']
    intermediate_colors = base_colors.dup << 'p'
    advanced_colors = intermediate_colors.dup << 'o'
    available_colors = []
    game_colors = []

    if num_colors == 4
      available_colors = base_colors
    elsif num_colors == 5
      available_colors = intermediate_colors
    else
      available_colors = advanced_colors
    end

    characters.times do
      game_colors << available_colors.sample
    end
    game_colors.join
  end

end
