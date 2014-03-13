class CreateArticleTermLinks < ActiveRecord::Migration
  def change
    create_table :article_term_links do |t|
      t.integer :article_id
      t.integer :term_id
      t.integer :ranking

      t.timestamps
    end
  end
end
