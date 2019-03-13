class Game
    def initialize()
        @guessesLeft = 4
        @hintUsed = false
        @word = createRandomWord()
        @guessedLetters = Array.new
        @correctGuesses = createBlankScoreArray()
    end
    
    def createRandomWord()
        wordArr = IO.readlines("../res/words.txt")
        return wordArr[Random.rand(wordArr.count - 1)].strip
    end
    protected :createRandomWord
    
    def createBlankScoreArray()
        return Array.new(@word.length, '_')
    end
    protected :createBlankScoreArray
        
    def getWord()
        @word
    end
    
    def getGuessesLeft()
        @guessesLeft
    end
    
    def getHintUsed()
        @hintUsed
    end
    
    def getScoreArray()
        return @correctGuesses
    end
    
    def getGuessedLetters()
        return @guessedLetters
    end
    
    def storeCorrectGuess(guess)
        @guessedLetters.push(guess)
        @correctGuesses.each_with_index do |item, index|
            if @word[index] == guess
                @correctGuesses[index] = guess
            end
        end
    end
    
    def storeIncorrectGuess(guess)
        @guessedLetters.push(guess)
        @guessesLeft -= 1
    end
    
    def useHint
         @hintUsed = true
         @guessesLeft -= 1
         tempArr = @word.split('')
         tempArr.each_with_index do |item, index|
            if !@guessedLetters.include?(tempArr[index])
                self.storeCorrectGuess(tempArr[index])
                break
            end
        end
    end
end