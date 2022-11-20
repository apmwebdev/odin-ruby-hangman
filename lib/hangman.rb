require_relative "hangman/game_engine"
require_relative "hangman/dictionary_manager"
require_relative "hangman/game_ui"
require_relative "hangman/io_manager"

hangman = GameEngine.new
hangman.play
