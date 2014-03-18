class Indexer
  
  def self.run
    Page.where(:page_id => 500..1000).each do |page|
      puts page.title
      text = page.getLatestText
      puts text.text
      procText = TextProcessor.new(text.text)
      Term.all.each do |term|
        #puts "Term id: #{term.id}"
        freq = 0
        term.nouns.each do |noun|
          freq += procText.frequency_of(noun)
        end
        if freq > 0
          puts "#{term.text} in #{page.title} with freq = #{freq}"
        end
      end

    end
  end
end