class GameUI
  attr_accessor :word, :hint_arr, :wrong_guesses, :num_guesses

  def initialize(word, hint_arr, wrong_guesses, num_guesses)
    @word = word
    @hint_arr = hint_arr
    @wrong_guesses = wrong_guesses
    @num_guesses = num_guesses
    clear_screen
    puts "Welcome to hangman!"
  end

  def render_main_game_screen(is_game_over = false)
    puts "\n#{num_guesses - wrong_guesses.length} guesses remaining"
    if wrong_guesses.length > 0
      puts "Wrong guesses so far: #{wrong_guesses.join(" ")}"
    end
    puts "\nWord: #{hint_arr.join(" ")} (#{word.length} letters)\n "
    unless is_game_over
      puts "Enter any letter to guess that letter, 1 to save, 2 to load"
    end
  end

  def show_win_message
    render_main_game_screen(true)
    puts "You win!"
  end

  def show_lose_message
    render_main_game_screen(true)
    puts "You lose."
  end

  private

  def clear_screen
    (system "clear") || (system "cls")
  end
end
