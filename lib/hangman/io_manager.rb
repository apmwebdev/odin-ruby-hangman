require "json"

class IOManager
  attr_reader :word, :hint_arr, :wrong_guesses, :num_guesses

  SAVE_FILENAME = "saved_game.json"

  def initialize(word, hint_arr, wrong_guesses, num_guesses)
    @word = word
    @hint_arr = hint_arr
    @wrong_guesses = wrong_guesses
    @num_guesses = num_guesses
  end

  def save_game
    save_data = {
      word: word,
      hint_arr: hint_arr,
      wrong_guesses: wrong_guesses,
      num_guesses: num_guesses
    }.to_json

    File.truncate(SAVE_FILENAME, 0) if File.exist?(SAVE_FILENAME)
    File.open(SAVE_FILENAME, "w") { |file| file.puts save_data }
  end

  def load_game
    if File.exist?(SAVE_FILENAME)
      save_file = File.open(SAVE_FILENAME, "r")
      save_file_contents = save_file.read
      save_file.close
      JSON.parse(save_file_contents)
    end
  end
end
