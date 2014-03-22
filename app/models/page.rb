class Page < ActiveRecord::Base
  self.table_name = "page"
  
  has_many :revisions, :foreign_key => 'rev_page'
  
  def getLatestText
    newest = revisions.order(:rev_timestamp).last
    text = Text.where(:old_id => newest.rev_text_id).first
  end
  
  def title
    page_title
  end
end