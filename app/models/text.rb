class Text < ActiveRecord::Base
  self.table_name = "text"
  
  has_many :revisions, :foreign_key => 'rev_text_id'
  
  def text
    old_text
  end

end