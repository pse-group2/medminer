require './Downloader'
require 'json'
#WICHTIG: schema für die DB:
#TABLE page mit ROW page_id (int), ROW page_title (text) und ROW text_id(int)
#TABLE text mit ROW page_id (int), ROW content (medium_blob) und ROW text_id(int)
#parameter
threadNumber = 45;
username = "root"
password = "toor"
dbname = "testwiki"

#mysql client und artikel-IDs
client = Mysql2::Client.new(:host => "localhost", :username => username, :password => password, :database => dbname)
file = open("wiki-IDs.json")
json = file.read
parsed = JSON.parse(json)
p totalLength = parsed.length.to_i

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
p "Running #{downloaders.count} downloaders..."
pct = 0
#loop ist nur für die anzeige. 
while pct < 100
  sum = 0
  downloaders.each do |d|
    sum += d.c
  end
  pct = (sum.to_f/totalLength.to_f*100).round(3)
  p "#{sum} of #{totalLength}. #{pct}%."
  sleep 1
end
#zeitmessung
t = finish-start
mm, ss = t.divmod(60)            #=> [4515, 21]
hh, mm = mm.divmod(60)           #=> [75, 15]
dd, hh = hh.divmod(24)           #=> [3, 3]
puts "Time elapsed: %d hours, %d minutes and %d seconds" % [hh, mm, ss]