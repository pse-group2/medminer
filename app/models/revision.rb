class Revision < ActiveRecord::Base
  self.table_name = "revision"
  
  belongs_to :page
  belongs_to :text
  
end