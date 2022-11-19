require "open-uri"

class DictionaryManager
  WORD_LIST_URL = "https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt".freeze
  DICT_FILENAME = "dictionary.txt".freeze

  def initialize
    maybe_create_dictionary
  end

  def maybe_create_dictionary
    unless File.exist?(DICT_FILENAME)
      remote_data = URI.open(WORD_LIST_URL)
      local_file = open(DICT_FILENAME, "a")
      remote_data.each_line do |line|
        if line.chomp.length >= 5 && line.chomp.length <= 12
          local_file.write(line)
        end
      end
      local_file.close
    end
  end

  def choose_word
    File.readlines(DICT_FILENAME).sample.chomp.upcase
  end
end
