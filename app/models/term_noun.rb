class TermNoun < ActiveRecord::Base
  
  belongs_to :word
  belongs_to :term
  
end
