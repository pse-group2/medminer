class TermTokenizer
  
  def self.fill_word_tables
    Term.all.each do |term|
      proc = TextProcessor.new(term.text)
      words = proc.words
      words.each do |word|
        f = Word.find_or_create_by(text: word, count: 0)
        id = f.id
        if TextProcessor.is_noun(word)
          Noun.find_or_create_by(term_id: term.id, word_id: id)
        end
      end
    end

  end

end