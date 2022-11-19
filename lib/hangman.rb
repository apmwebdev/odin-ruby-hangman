require_relative "hangman/game_engine"
require_relative "hangman/dictionary_manager"
require_relative "hangman/game_ui"

hangman = GameEngine.new
hangman.play
