class GamesController < ActionController::Base
    def play
        
        if cookies[:sessionID] && !params[:newGame]
            sessionID = cookies[:sessionID]
            currentGame = continueGame(sessionID)
        else
            currentGame = createGame()
        end
        
        @game = currentGame
        userGuess = params[:guessed_letter]
        
        if(userGuess)
           takeGuessInput(userGuess)
        end
        
        checkForWinner()   
        saveGame()
        
        createUI()
    end
    
    def createUI
        @wordUI = @game.correctLettersGuessed
        @guessesLeft = @game.guessCount
        @hangManImg = "h" + (@game.guessCount - 7).abs.to_s  + ".gif"
    end
    
    def saveGame
        @game.save!
    end
    
    def storeCorrectGuess(guess)
        @game.guessedLetters.concat(guess)
        tempArr = @game.correctLettersGuessed.split(' ')
        tempArr.each_with_index do |item, index|
            if @game.word[index] == guess
                tempArr[index] = guess
            end
        end
        @game.correctLettersGuessed = tempArr.join(' ')
    end
    
    def checkForWinner
        if(@game.correctLettersGuessed.delete(' ') == @game.word)
            @response = "Goodjob you win!"
        end
    end
    
    def storeIncorrectGuess(guess)
        @game.guessedLetters.concat(guess)
        @game.guessCount -= 1
    end
    
    def createRandomWord()
        wordArr = IO.readlines("app/assets/words.txt")
        return wordArr[Random.rand(wordArr.count - 1)].strip
    end
    
    def createGame
        sessionID = SecureRandom.uuid
        cookies[:sessionID] = sessionID
        word = createRandomWord()
        newGame = Game.create!(:sessionID => sessionID,
                            :word =>  word, 
                            :guessCount => 6,
                            :guessedLetters => "",
                            :correctLettersGuessed => createBlankScoreArray(word).join(' '))
        return newGame
    end
    
    def continueGame(sessionID)
        savedGame = Game.where("sessionID = ?", sessionID).first
        if(!savedGame)
            return createGame()
        end
        return savedGame
    end
    
    def createBlankScoreArray(word)
        return Array.new(word.length, '_')
    end

    def takeGuessInput(guess)
       if guess.length > 1
            @response = "Too many letters. One letter per turn."
       elsif guess.length == 0 || guess == ''
           if(@game.guessCount == 0)
               @response = "Incorrect choice. Game over."
           else 
               @response = ""
           end
       else
           if @game.guessedLetters.include?(guess)
              @response =  "Already guessed #{guess}"
           elsif @game.word.include?(guess)
              storeCorrectGuess(guess) 
              @response =  "Correct choice!"
           else
               storeIncorrectGuess(guess)
               if(@game.guessCount == 0)
                   @response = "Incorrect choice. Game over."
               else
                   @response = "Incorrect choice."
               end
           end
       end
    end

end
