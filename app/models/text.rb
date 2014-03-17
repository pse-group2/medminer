class Text < ActiveRecord::Base
  self.table_name = "text"
  
  belongs_to :page
end