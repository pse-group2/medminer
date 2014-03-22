class Page < ActiveRecord::Base
  self.table_name = "page"
  
  has_many :revisions
  
  def getLatestText
    id = Revision.where(:rev_page => page_id).order(:rev_timestamp).last.rev_text_id
    text = Text.where(:old_id => id).first
  end
  
  def title
    page_title
  end
end