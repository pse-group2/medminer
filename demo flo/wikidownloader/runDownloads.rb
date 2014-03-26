require './Downloader'
require 'json'
#WICHTIG: schema für die DB:
#TABLE page mit ROW page_id (int) und ROW page_title (text)
#TABLE text mit ROW page_id (int) und ROW content (medium_blob)
#parameter
threadNumber = 45;
username = "root"
password = "team2"
dbname = "newtestwiki"

#mysql client und artikel-IDs
client = Mysql2::Client.new(:host => "localhost", :username => username, :password => password, :database => dbname)
file = open("medarticles.json")
json = file.read
parsed = JSON.parse(json)
totalLength = parsed.length.to_i

#erstelle downloader
downloaders = []
threads = []
i = 0
while i < threadNumber
  downloaders << Downloader.new(dbname, username, password, parsed[(totalLength/threadNumber)*i+i..(totalLength/threadNumber)*(i+1)+i], "downloader#{i+1}")
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
finish = Time.now
p "Time elapsed: #{(finish-start)/60} minutes"