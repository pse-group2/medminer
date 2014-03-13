class Term < ActiveRecord::Base
  
  has_many :article_term_links
end
