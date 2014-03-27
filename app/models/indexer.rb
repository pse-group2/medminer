class Indexer
  
  def self.index_nouns
    TermNoun.all.group(:word_id).each do |noun|
      noun_word = noun.word
      puts noun_word.text

      texts = Text.where("content LIKE '%#{noun_word.text}%'")
      texts.each do |text|
        freq = measure_frequency(noun_word.text, text.content)
        update_total_frequency(noun.word, freq)

        terms = noun.word.term_word_links.map {|tw| Term.find_by_id(tw.term_id)}
        update_index(terms, text.page, freq)
      end
    end
  end

  def self.measure_frequency(noun_str, text_str)
    procText = TextProcessor.new(text_str)
    procText.frequency_of noun_str
  end

  def self.update_total_frequency(word, freq)
    if freq > 0
    word.count += freq
    word.save
    end
  end

  def self.update_index(terms, page, freq)
    if freq > 0
      terms.each do |term|
        indexed = ArticleTermLink.where(:article_id => page.id, :term_id => term.id).first_or_initialize
        indexed.ranking += freq
        indexed.save
      end
    end
  end

end
