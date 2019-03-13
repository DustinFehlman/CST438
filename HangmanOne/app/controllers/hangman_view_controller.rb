class HangmanViewController
    def initialize()
        require_relative "../models/game.rb"
        @game = Game.new
    end
    
    def returnWord()
        return @game.getWord
    end
    
    def returnGuessesLeft()
        return @game.getGuessesLeft
    end
    
    def returnScoreArray()
        return @game.getScoreArray
    end
    
    def isGameAWinner()
        return self.returnScoreArray.index('_') == nil
    end
    
    def takeGuessInput(guess)
       if guess == "hint"
           if @game.getGuessesLeft > 1 and !@game.getHintUsed
               @game.useHint()
               return "Hint used"
           else
               return "No hints left"
           end
       elsif guess.length > 1
            return "Too many letters. One letter per turn."
       else
           if @game.getGuessedLetters.include?(guess)
               return "Already guessed #{guess}"
           elsif @game.getWord.include?(guess)
               @game.storeCorrectGuess(guess) 
               return "Correct choice!"
           else
               @game.storeIncorrectGuess(guess)
               "Incorrect choice."
           end
       end
    end
end