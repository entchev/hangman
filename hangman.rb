class Hangman
  DICTIONARY = ["spiraling", "cat", "freedom", "pizza", "traverse"]

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    return true if @attempted_chars.include?(char)
    return false if !@attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    result = []
    @secret_word.each_char.with_index do |ele, idx|
      if ele == char
        result << idx
      end
    end
    result
  end

  def fill_indices(char, arr)
    arr.each do |i|
      @guess_word[i] = char
    end
  end

  def try_guess(char)
    if self.already_attempted?(char)
      puts "that has already been attempted"
      return false
    end

    matching = self.get_matching_indices(char)
    self.fill_indices(char, matching)

    if !@secret_word.include?(char)
      @remaining_incorrect_guesses -= 1
    end

    @attempted_chars << char
    return true

  end

  def ask_user_for_guess
    puts "Enter a char"
    char = gets.chomp
    self.try_guess(char)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "YOU WIN! GRATS!"
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses != 0 
      return false
    else
      puts "YOU LOST! BETTER LUCK NEXT TIME!"
      true
    end
  end

  def game_over?
    if self.win? 
      puts @secret_word
      return true
    end

    if self.lose? 
      puts @secret_word
      return true
    end

    false
  end

end
