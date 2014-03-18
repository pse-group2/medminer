require 'treat'
require 'stanford-core-nlp'

include Treat::Core::DSL
Treat.core.language.default = 'german'

class Term < ActiveRecord::Base

  has_many :article_term_links
  
  #Returns the words in this term.
  def words
    TextProcessor.new(text).words
  end

  #Returns the nouns from this term.
  def nouns
    TextProcessor.new(text).nouns
  end
end
