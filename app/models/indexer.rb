class Indexer
  def self.run
    Page.all.each do |page|
      puts page.title
      text = page.getLatestText

      procText = TextProcessor.new(text.text)

      Noun.all.each do |noun|
        noun_word = Word.find_by_id(noun.word_id)
        freq = procText.frequency_of(noun_word.text)

        if freq > 0
          puts "#{noun_word.text} in #{page.title} with freq = #{freq}"

          old_freq = noun_word.count
          noun_word.count = old_freq + freq
          noun_word.save

          indexed = ArticleTermLink.where(:article_id => page.page_id, :term_id => noun.term_id).first_or_initialize
          indexed.ranking += freq
          indexed.save
        end

      end

    end
  end
end