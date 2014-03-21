class CreateNouns < ActiveRecord::Migration
  def change
    create_table :nouns do |t|
      t.integer :term_id
      t.integer :word_id

      t.timestamps
    end
  end
end
