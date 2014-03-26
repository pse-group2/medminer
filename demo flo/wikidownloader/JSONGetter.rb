#dieses script lädt ein mit http://tools.wmflabs.org/catscan2/quick_intersection.php erzeugtes JSON file ("source") runter und extrahiert daraus page_id, page_title und page_latest in ein JSON file ("filename")

require 'json'
require 'open-uri'

class JSONGetter
  
  def initialize(filename, source)
    @filename = filename
    @json_url = source
  end
  
  def download()
    #das zeugs runterladen - downloadanzeige eingebaut, da die seite lange hat zum generieren...
    print "Downloading JSON file...\n"
    an_int = 1
    open(@filename, 'wb') do |file|
      file << open(@json_url, :content_length_proc => lambda{|content_length|
           bytes_total = content_length},
         :progress_proc => lambda{|bytes_transferred|
           print "\r%0.2f MB downloaded" % (bytes_transferred.to_f/1024.to_f/1024.to_f)
         }).read
    end

    print "\nDownload finished! Stored in #{@filename}. Parsing...\n"

    #heruntergeladenes file einlesen
    file = open(@filename)
    json = file.read
    parsed = JSON.parse(json)
    pages = parsed["pages"]

    print "Parsing finished! Extracting relevant data...\n"

    #nötige daten extrahieren, in array speichern
    result = []
    c = 0
    pages.each do |entry|
      newHash = {}
      newHash["page_id"] = entry["page_id"]
      newHash["page_title"] = entry["page_title"]
      newHash["text_id"] = entry["page_latest"]
      result << newHash
      c+=1
      print "\r#{c} of #{pages.count} entries extracted."
    end

    print "\nWriting to file #{@filename}...\n"
    #wieder reinschreiben
    File.open(@filename,"wb") do |f|
      f.write(result.to_json)
    end
    
    print "JSON file is finished!\n"
    
  end
  
end