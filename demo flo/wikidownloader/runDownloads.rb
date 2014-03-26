require './Downloader'
require './JSONGetter'
require 'json'
require 'open-uri'

#WICHTIG: schema für die DB:
#TABLE page mit ROW page_id (int), ROW page_title (text) und ROW text_id(int)
#TABLE text mit ROW page_id (int), ROW content (medium_blob) und ROW text_id(int)
#parameter - username, password and dbname for the local mysql DB, filename is where the JSON file is located and source is the address of the new json file
threadNumber = 100;
username = "root"
password = "toor"
dbname = "testwiki"
filename = 'articles.json'
source = "http://tools.wmflabs.org/catscan2/quick_intersection.php?lang=de&project=wikipedia&cats=Medizin&ns=0&depth=-1&max=100000&start=0&format=json&redirects=&callback="

#falls kein json file vorhanden ist, wird ein json file von der angegebenen adresse heruntergeladen und vereinfacht (gespeichert in filename).

unless File.exists?(filename)
  jsongetr = JSONGetter.new(filename, source)
  jsongetr.download
end

#mysql client und artikel-IDs
client = Mysql2::Client.new(:host => "localhost", :username => username, :password => password, :database => dbname)
file = open(filename)
json = file.read
parsed = JSON.parse(json)
totalLength = parsed.length

#erstelle downloader
downloaders = []
threads = []
i = 0
while i < threadNumber
  downloaders << Downloader.new(dbname, username, password, parsed[(totalLength/threadNumber)*i+i..(totalLength/threadNumber)*(i+1)+i], "Downloader#{i+1}")
  i+=1
end

#zeitmessung
start = Time.now

#downloaders in threads starten
downloaders.each do |d|
    threads << Thread.new{d.startDownload}
end
print "Running #{downloaders.count} downloaders on #{parsed.length.to_i} entries...\n"
pct = 0
#loop ist nur für die anzeige. 
while pct < 100
  sum = 0
  downloaders.each do |d|
    sum += d.c
  end
  pct = (sum.to_f/totalLength.to_f*100).round(3)
  print "\rDownloading: #{sum} of #{totalLength} articles\t#{pct}%"
  sleep 1
end
#zeitmessung
finish = Time.now
t = finish-start
mm, ss = t.divmod(60)          
hh, mm = mm.divmod(60)          
print "Time elapsed: %d hours, %d minutes and %d seconds\n" % [hh, mm, ss]