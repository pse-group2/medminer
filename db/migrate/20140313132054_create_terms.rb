class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :text
      t.string :icd

      t.timestamps
    end
  end
end
