class Word < ActiveRecord::Base
  
  has_many :term_word_links
  has_many :nouns
end
