class Text < ActiveRecord::Base
  self.table_name = "text"
  
  has_one :page
  belongs_to :page
  
  def text
    content
  end

end