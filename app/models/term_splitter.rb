class TermSplitter
  def self.fill_word_tables
    Term.all.each do |term|
      words = term.words
      words.each do |word|
        f = Word.find_or_create_by(text: word)
        id = f.id
        if TextProcessor.is_noun(word)
          Noun.find_or_create_by(term_id: term.id, word_id: id)
        end
      end
    end

  end

end