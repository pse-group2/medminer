require './relevanceFinder.rb'
relevanceFinder = RelevanceFinder.new
entryDir = Dir.entries("entries")
File.open('output.txt', 'w') {}
entryDir.each do |entry|
  string = "entries/" + entry
  unless entry == "." || entry == ".."
    output = relevanceFinder.getRelevantWords(document (string))
    File.write('output.txt', entry +"\n" , File.size('output.txt'), mode: 'a')
    output.each do |term|
      File.write('output.txt', term[0] + " - " + term[1].to_s + "\n", File.size('output.txt'), mode: 'a')
    end
    File.write('output.txt', "\n" , File.size('output.txt'), mode: 'a')
  end
end