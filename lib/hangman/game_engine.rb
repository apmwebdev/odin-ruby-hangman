class GameEngine
  def initialize
    gather_external_resources
  end

  def play
    puts "Play"
  end

  private

  def gather_external_resources
    ResourceFetcher.create_dictionary
  end
end
