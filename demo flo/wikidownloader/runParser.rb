require 'mysql2'
require './Parser.rb'
threadNumber = 1;
username = "root"
password = "toor"
dbname = "medwiki"

client = Mysql2::Client.new(:host => "localhost", :username => username, :password => password, :database => dbname)
texts = client.query("SELECT * FROM text").to_a
p texts[0]["page_id"]
totalLength = texts.count
parsers = []
threads = []
i = 0
while i < threadNumber
  parsers << Parser.new(texts[(totalLength/threadNumber)*i+i..(totalLength/threadNumber)*(i+1)+i], "Parser no. #{i+1}")
  #print "Created new parser from length #{(totalLength/threadNumber)*i+i} to #{(totalLength/threadNumber)*(i+1)+i}"
  i+=1
end

start = Time.now

parsers.each do |p|
    threads << Thread.new{p.parse}
end

print "Running #{parsers.count} downloaders on #{totalLength.to_i} entries...\n"
pct = 0

while pct < 100
  sum = 0
  parsers.each do |d|
    sum += d.c
    print "\n#{d.name}: #{d.c}\n"
  end
  pct = (sum.to_f/totalLength.to_f*100).round(3)
  print "\rParsing: #{sum} of #{totalLength} articles\t#{pct}%"
  sleep 1
  if pct > 1
    finish = Time.now
    t = finish-start
    mm, ss = t.divmod(60)          
    hh, mm = mm.divmod(60)      
    print "\nReached 1%! Time elapsed: %d hours, %d minutes and %d seconds. Estimated time for 100%: #{t*100}\n" % [hh, mm, ss]
    
  end
end

finish = Time.now
t = finish-start
mm, ss = t.divmod(60)          
hh, mm = mm.divmod(60)          
print "\nTime elapsed: %d hours, %d minutes and %d seconds\n" % [hh, mm, ss]