class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = '-' * word.length
  end
  
  # User guesses a letter
  # If guess is not a letter, throw ArgumentError
  # Check if letter is valid, if not return FALSE
  # Letter is added to guesses if in @word
  # If letter not in @word, add letter to wrong guesses
  def guess(letter)
    
    # Check that letter is a valid guess
    raise ArgumentError, "Guess is not a letter" unless (letter =~ /[a-zA-Z]/)
    
    # Make sure the letter hasn't been previously guessed
    letter.downcase!
    if @wrong_guesses.include?(letter) or @guesses.include?(letter)
      return false
    end
    
    # Check if the word contains the guess
    if @word.include? letter
      @guesses += letter
      for index in 0...@word.length
        if @word[index] == letter
          @word_with_guesses[index] = letter
        end
      end
    else
      @wrong_guesses += letter
    end
    puts @word_with_guesses
    return true
  end
  
  def check_win_or_lose
    # If the user has made 7 or more false guesses they lose
    if @wrong_guesses.length >= 7
      return :lose
    end
    
    # If word_with_guesses contains a -, that means there are more letters that need to be found
    @word_with_guesses.split('').each do |i|
      if i == '-'
        return :play
      end
    end
    
    return :win
  end
    
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
