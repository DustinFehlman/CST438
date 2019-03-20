class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :sessionID
      t.string :word
      t.string :guessedLetters
      t.integer :guessCount
      t.string :correctLettersGuessed
      t.timestamps  
    end
  end
end
