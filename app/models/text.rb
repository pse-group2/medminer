class Text < ActiveRecord::Base
  self.table_name = "text"
  
  belongs_to :page
  
  def text
    content
  end

end