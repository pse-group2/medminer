class Text < ActiveRecord::Base
  self.table_name = "text"
  
  belongs_to :page
  
  # Returns all the terms that occur in the text as an array.
  def terms
    terms_in_article = Array.new
    
    Term.all.each do |term|
      if old_text.include? term.text
        terms_in_article.push term.text
      end
    end
    
    terms_in_article
  end
end