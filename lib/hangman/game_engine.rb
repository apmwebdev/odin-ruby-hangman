class GameEngine
  attr_reader :word, :game_over, :hint_arr, :wrong_guesses, :dict_manager,
    :game_ui, :io_manager

  NUM_GUESSES = 6

  def initialize
    @dict_manager = DictionaryManager.new
    @dict_manager.maybe_create_dictionary
    @word = @dict_manager.choose_word
    @hint_arr = Array.new(word.length) { "_" }
    @wrong_guesses = []
    @game_ui = GameUI.new(@word, @hint_arr, @wrong_guesses, NUM_GUESSES)
    @io_manager = IOManager.new(@word, @hint_arr, @wrong_guesses, NUM_GUESSES)
    @game_over = false
  end

  def play
    game_ui.start_game
    until game_over
      game_ui.render_main_game_screen
      get_user_input
      check_for_game_over
    end
  end

  private

  def get_user_input
    input_is_valid = false
    until input_is_valid
      input = gets.chomp
      next if input.length == 0
      input = input[0].upcase
      unless /[A-Z]/.match?(input) || input == "1" || input == "2"
        next
      end
      if /[A-Z]/.match?(input)
        input_is_valid = maybe_submit_guess(input)
      elsif input == "1"
        input_is_valid = true
        save_game
      elsif input == "2"
        input_is_valid = true
        load_game
      end
    end
  end

  def maybe_submit_guess(input)
    if wrong_guesses.include?(input)
      false
    elsif hint_arr.include?(input)
      false
    else
      submit_valid_guess(input)
      true
    end
  end

  def submit_valid_guess(input)
    if word.include?(input)
      word.chars.each_with_index do |char, index|
        if char == input
          @hint_arr[index] = char
        end
      end
    else
      @wrong_guesses.push(input)
    end
  end

  def check_for_game_over
    if !hint_arr.include?("_")
      win
    elsif wrong_guesses.length >= NUM_GUESSES
      lose
    end
  end

  def win
    @game_over = true
    game_ui.show_win_message
  end

  def lose
    @game_over = true
    game_ui.show_lose_message
  end

  def save_game
    io_manager.save_game
    game_ui.show_saved
  end

  def load_game
    data = io_manager.load_game
    if data.nil?
      game_ui.show_no_save_data
    else
      @word = data["word"]
      @hint_arr = data["hint_arr"]
      @wrong_guesses = data["wrong_guesses"]
      @game_ui = GameUI.new(@word, @hint_arr, @wrong_guesses, NUM_GUESSES)
      @io_manager = IOManager.new(@word, @hint_arr, @wrong_guesses, NUM_GUESSES)
      game_ui.show_loaded
    end
  end
end
