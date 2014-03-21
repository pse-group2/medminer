class CreateTermWordLinks < ActiveRecord::Migration
  def change
    create_table :term_word_links do |t|
      t.integer :term_id
      t.integer :word_id

      t.timestamps
    end
  end
end
