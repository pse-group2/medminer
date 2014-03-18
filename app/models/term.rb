require 'treat'
require 'stanford-core-nlp'
include Treat::Core::DSL
Treat.core.language.default = 'german' 

class Term < ActiveRecord::Base
  
  has_many :article_term_links
  
  #Returns the words in this term
  def words
    phr = phrase text
    phr.apply(:tokenize)
    phr.to_a
  end
  
  def nouns
    nouns = Array.new
    words.each do |word|
      if word.category == 'noun' 
        nouns.push word
      end
    end
    nouns
  end
end
