class Indexer
  
  @parsedTexts = {}
  
  def self.index_nouns
    totalCount = TermNoun.all.group(:word_id).all.count
    print "Iterating over #{totalCount} nouns"
    termCounter = 0
    TermNoun.all.group(:word_id).each do |noun|
      noun_word = noun.word
      texts = Text.where("content LIKE '%#{noun_word.text}%'")
      print "\n#{termCounter}/#{totalCount} nouns. Processing noun '#{noun_word.text}'. Found #{texts.count} articles\n"
      articleCounter = 0
      texts.each do |text|
        page_title = Page.where(:text_id => text.text_id).first.page_title
        print "\r#{articleCounter}/#{texts.count} articles parsed"
        freq = measure_frequency(noun_word.text, text.content, text.text_id)
        update_total_frequency(noun.word, freq)
        terms = noun.word.term_word_links.map {|tw| Term.find_by_id(tw.term_id)}
        update_index(terms, text.page, freq)
        articleCounter+=1
      end
      termCounter+=1
    end
  end

  def self.measure_frequency(noun_str, text_str, text_id)
    if @parsedTexts["#{text_id}"] == nil
      procText = TextProcessor.new(text_str)
      @parsedTexts["#{text_id}"] = procText
    else
      procText = @parsedTexts["#{text_id}"]
    end
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
