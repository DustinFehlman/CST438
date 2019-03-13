require_relative "../controllers/hangman_view_controller.rb"
controller = HangmanViewController.new

puts "Welcome to Hangman!"
puts "Enter a guess or 'hint'!"
while controller.returnGuessesLeft > 0 do
    if controller.isGameAWinner
        puts "Congrats! You guessed #{controller.returnWord}"
        break
    end
    
    puts "You have #{controller.returnGuessesLeft} guesses left."
    puts controller.returnScoreArray.join(' ')
    puts controller.takeGuessInput(gets.chomp)
    if controller.returnGuessesLeft <= 0
        puts "Sorry you lose."
    end
    puts
end