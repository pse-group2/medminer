class RenameNounWordTable < ActiveRecord::Migration
  def change
    rename_table :noun_words, :term_nouns
  end
end
