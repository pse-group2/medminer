require './text_processor.rb'

class Parser

  attr_accessor :pct
  attr_accessor :c
  attr_accessor :name
  
  def initialize(pages, name)
    @pages = pages
    @c = 0
    @name = name
    @length = @pages.length.to_i
    @pct = 0
    @parsedTexts = {}
    print "initialized new parser with name '#{@name}'. Received #{@length} texts\n"
  end

  def parse
    @pages.each do |page|
      #print "\n#{@name} parsing page #{page["page_id"]}\n"
      @pct = (@c.to_f/@length.to_f*100).round(3)
      prc = TextProcessor.new(page["content"])
      @parsedTexts[page["page_id"]] = prc
      @c+=1
    end
  end
  
end

  