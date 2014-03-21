=begin

extrahiert anhand des beiliegenden .json files medizinische artikel aus der alten DB und bewegt sie in eine neue

PLS NOTE: ihr müsst eine gefüllte wiki haben (unten "dewiki") und eine leere (bzw. ohne wichtigen inhalt - wird gelöscht) mit dem GLEICHEN SCHEMA (unten "medwiki")
die namen könnt ihr natürlich anpassen...
die neue DB sieht genau gleich aus wie die alte, ausser, dass eben nur medizinische artikel enthalten sind

hinweis: ihr könnt nicht einfach ein eigenes JSON file einlesen, müsstet es noch modifizieren, wenn ihr das machen wollt...
=end



require 'json'
require 'mysql2'
#namen der alten gefüllten und neuen leeren DB - müssen existieren!
#KANN MAN ÄNDERN
oldwiki = "dewiki"
newwiki = "medwiki"
#neuen client erstellen
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "toor", :database => "#{oldwiki}")
#erstellen von neuen leeren tabellen mit dem gleichen schema wie die originale, löschen wenn sie schon existieren
client.query("SHOW TABLES LIKE 'page_new'").count == 1 ? client.query("DELETE FROM page_new") : client.query("CREATE TABLE page_new LIKE page;")
client.query("SHOW TABLES LIKE 'text_new'").count == 1 ? client.query("DELETE FROM text_new") : client.query("CREATE TABLE text_new LIKE text;")
client.query("SHOW TABLES LIKE 'revision_new'").count == 1 ? client.query("DELETE FROM revision_new") : client.query("CREATE TABLE revision_new LIKE revision;")
#lesen der aus wikipedia gefilterten medizinischen artikel
file = open("medarticles.json")
json = file.read
parsed = JSON.parse(json)
c = 0
pct = 0
length = parsed.length
#iterieren über die IDs der medizinischen artikel, kopieren der entsprechenden zeilen aus den drei tabellen
parsed.each do |name|
  check = client.query("SELECT * FROM page WHERE page_id = #{name["page_id"]}").count
  if check == 1
    p "Copying page with ID #{name["page_id"]}. #{c} of #{length} entries found and copied..."
    #die page mit der momentanen ID wird kopiert
    client.query("INSERT INTO page_new SELECT * FROM page WHERE page_id = #{name["page_id"]}")
    #same for the revision
    client.query("INSERT INTO revision_new SELECT * FROM revision WHERE rev_page = #{name["page_id"]}")
    #ID der revision wird benötigt, um den dazugehörigen text zu finden
    q = client.query("SELECT * FROM revision WHERE rev_page = #{name["page_id"]}")
    #ja, ich weiss, sieht aus wie sau - egal, es funktioniert!
    revID = (q.select { |row| row["rev_text_id"]})[0]["rev_text_id"]
    #dann holt man noch die texte
    client.query("INSERT INTO text_new SELECT * FROM text WHERE old_id = #{revID}")
    c+=1
  end
end
moveClient = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "toor")
#alte tables löschen, nach bedarf anpassen
client.query("DROP table #{newwiki}.page")
client.query("DROP table #{newwiki}.text")
client.query("DROP table #{newwiki}.revision")
#tables aus der source- in die target-DB bewegen
client.query("ALTER TABLE #{oldwiki}.page_new RENAME medwiki.page")
client.query("ALTER TABLE #{oldwiki}.text_new RENAME medwiki.text")
client.query("ALTER TABLE #{oldwiki}.revision_new RENAME medwiki.revision")
