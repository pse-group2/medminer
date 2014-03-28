require 'treat'
require 'stanford-core-nlp'
include Treat::Core::DSL
Treat.core.language.default = 'german' 

# This helper class provides basic methods to process text chunks
class TextProcessor
  
  def initialize(text)
    @text = text.to_entity
    @text.do(:chunk, :segment, :tokenize)
  end
  
  def frequency_of(word)
    @text.frequency_of(word)
  end
  
  def word_count
    @text.word_count
  end
  
  # Returns an array of all the words occurring in the text.
  def words
    @text.words.map {|word| word.to_s}.uniq
  end
  
  # Returns an array of all the nouns occurring in the text.
  def nouns
    nouns = Array.new
    words.each do |word|
      if word.category == 'noun' 
        nouns.push word
      end
    end
    nouns
  end
  
  def self.is_noun(word)
    if word.category == 'noun'
      result = true
    else 
      result = false
    end
      result
  end
end