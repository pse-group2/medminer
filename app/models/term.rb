require 'treat'
require 'stanford-core-nlp'

include Treat::Core::DSL
Treat.core.language.default = 'german'

class Term < ActiveRecord::Base

  has_many :article_term_links
  has_many :term_nouns
  has_many :term_word_links
  
end
