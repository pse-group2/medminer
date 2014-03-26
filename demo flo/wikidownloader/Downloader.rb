require 'net/http'
require 'uri'
require 'nokogiri'
require 'mysql2'

class Downloader

  attr_accessor :pct
  attr_accessor :c
  attr_accessor :name
  
  def initialize(dbname, username, password, array, name)
    @client = Mysql2::Client.new(:host => "localhost", :username => username, :password => password, :database => dbname)
    @input = array
    @c = 0
    @length = @input.length.to_i
    @pct = 0
    @name = name
  end

  def openURL(url)
    Net::HTTP.get(URI.parse(url))
  end
  

  def startDownload
    @input.each do |name|
      #p "#{@name}: #{(@c.to_f/@length.to_f*100).round(3)}%"
      @pct = (@c.to_f/@length.to_f*100).round(3)
      check = @client.query("SELECT * FROM page WHERE page_id = #{name["page_id"]}").count
      if check == 0
        url = "http://de.wikipedia.org/w/index.php?curid=#{name["page_id"]}"
        doc = Nokogiri::HTML(openURL(url))
        text = ''
        doc.css('p,h1').each do |e|
          text << e.content
        end
        pquery = "INSERT INTO page (page_id, page_title) VALUES(#{name["page_id"]}, '#{name["page_title"].gsub("'", %q(\\\'))}')"
        tquery = "INSERT INTO text (page_id, content) VALUES(#{name["page_id"]}, '#{text.gsub("'", %q(\\\'))}')"
        @client.query(pquery)
        @client.query(tquery)
      end
      @c+=1
    end
  end
  
end

  