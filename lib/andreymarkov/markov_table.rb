require "andreymarkov/configuration"

class MarkovTable

  SAVE_FILE_NAME = ".andrey"

  def initialize(should_load = true)
    load_dump(should_load)
  end

  def make_sentence
    words = [random_starter_word]
    while words.last != :end
      words << select_next_word(words.last)
    end

    #cut off the trailing :end
    words[0...words.length-1].join (" ")
  end

  def update(word, next_word)
    @transition_table[word] ||= make_hash
    @transition_table[word][next_word] += 1
  end

  def save_dump
    File.open(SAVE_FILE_NAME,'wb') do |f|
      f.write Marshal.dump(@transition_table)
    end
  end

  def load_dump(should_load)
    if File.exists? SAVE_FILE_NAME and should_load
      @transition_table = Marshal.load(File.binread(SAVE_FILE_NAME))
    else
      @transition_table = {}
    end
  end

  def sufficiently_populated?
    start_words.count > 10
  end

  private

  def start_words
    @transition_table.keys
  end

  def make_hash
    h = Hash.new
    h.default = 0
    h
  end

  def select_next_word(word)
    choices = @transition_table[word]
    build = []
    choices.each do |key, value|
      build << [key]*value
    end

    build.flatten.sample
  end

  def random_starter_word
    if AndreyMarkovConfiguration.instance.verbose
      puts "possible keys"
      p start_words
    end
    start_words.sample
  end
end
