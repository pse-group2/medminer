require 'treat'
include Treat::Core::DSL

class Term < ActiveRecord::Base
  
  has_many :article_term_links
  
  #Returns the words in this term
  def words
    phr = phrase text
    phr.apply(:tokenize)
    phr.to_a
  end
end
