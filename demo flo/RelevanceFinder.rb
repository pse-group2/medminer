require 'treat'
require 'json'
require 'pp'
include Treat::Core::DSL

class RelevanceFinder

  def getRelevantWords(input)
    #Segment text into sentences and words
    input.apply(:chunk, :segment, :tokenize)
    #create downcased list of every type
    @downcased_words = input.words.map { |word| word.to_s.downcase }.uniq
    #get total word count
    @totalWordCount = input.word_count  
    #get overall frequency for all words - only words that are both in the list and the text
    totalFrequency = getTotalFrequency(input)
    #get title occurrance 
    titleList = isInTitle(input, totalFrequency)
    #get frequency in first paragraph 
    firstParagraphList = isInFirstParagraph(input, titleList)
    #print stuff
    #titleList.each do |entry|
    #  puts "#{entry[0]} kommt #{entry[1]} mal vor (#{entry[1].to_f/@totalWordCount.to_f*100}% des gesamten Texts). #{if entry[2] == 1
    #  "Kommt im Titel vor. "end}#{if entry[3] != 0
      # "Kommt #{entry[3].to_s} mal im ersten Abschnitt vor."
    #  end}"
    #end
    output = []
    titleList.each do |entry|
      output << [entry[0], getRating(entry)]
    end
    return output
  end
  
  def getRating(input)
    rating = 0
    input[2] == 1 ? rating+=50 : nil
    rating += (input[1]/@totalWordCount.to_f*10000)
    rating += (input[3]*10)
    return rating
  end
  
  #returns array of arrays, containing each word and its frequency
  def getTotalFrequency(input)
    #get frequency of every word, store in hash
    word_hash = {}
    @downcased_words.each do |w|
      word_hash[w] = input.frequency_of(w)
    end
    #sort hash by popularity
    word_popularity = word_hash.sort_by { |key, value| value }.reverse
    #read code file, extract names
    file = open("AB_codes.json")
    json = file.read
    keywords = []
    parsed = JSON.parse(json)
    parsed.each do |name|
      keywords << name["text"]
    end
    #downcase keywords
    keywords = keywords.map { |word| word.to_s.downcase }.uniq
    #extract words contained in keywords
    filtered_results = word_popularity.select do |key, value|
      keywords.include? key
    end
  end
  
  def isInTitle(text, foundWords)
    #get words from the first title, downcase
    title = text.titles[0].to_s.downcase
    #iterate words, add 1 to word array for "is in title", 0 for "is not"
    foundWords.each do |word|
      if title.include?(word[0])
        word << 1
      else
        word << 0
      end
    end
  end
  
  #iterate words, adds count of word in title to word array
  def isInFirstParagraph(text, foundWords)
    foundWords.each do |word|
      word << text.paragraphs[0].frequency_of(word[0])
    end
  end

end

