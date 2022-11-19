require "open-uri"

class ResourceFetcher
  WORD_LIST_URL = "https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt".freeze

  def self.create_dictionary
    unless File.exist?("dictionary.txt")
      remote_data = URI.open(WORD_LIST_URL)
      local_file = open("dictionary.txt", "a")
      remote_data.each_line do |line|
        if line.chomp.length >= 5 && line.chomp.length <= 12
          local_file.write(line)
        end
      end
      local_file.close
    end
  end
end
