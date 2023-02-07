class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

  def self.random_word
    DICTIONARY.sample
  end

  def initialize()
    @secret_word = self.class.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(c)
    @attempted_chars.include?(c)
  end

  def get_matching_indices(c)
    return [] if !@secret_word.include?(c)

    (0 ... @secret_word.length).select { |i| @secret_word[i] == c }
  end

  def fill_indices(c, arr)
    arr.each { |i| @guess_word[i] = c }
  end

  def try_guess(c)
    if already_attempted?(c)
      puts "that has already been attempted"
      return false
    end

    @attempted_chars << c
    @remaining_incorrect_guesses -= 1 if !@secret_word.include?(c)
    fill_indices(c, get_matching_indices(c))

    true
  end

  def ask_user_for_guess
    puts "Enter a char:"
    try_guess(gets.chomp)
  end

  def win?
    puts "WIN" if @guess_word.join("") == @secret_word
    @guess_word.join("") == @secret_word
  end

  def lose?
    puts "LOSE" if @remaining_incorrect_guesses == 0
    @remaining_incorrect_guesses == 0
  end

  def game_over?
    over = win? || lose?
    puts @secret_word if over
    over
  end
end
