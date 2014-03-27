class RenameNounTable < ActiveRecord::Migration
  def change
    rename_table :nouns, :noun_words
  end
end
