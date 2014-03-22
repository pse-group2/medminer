class ArticleTermLink < ActiveRecord::Base

  belongs_to :page
  belongs_to :term
  
  after_initialize :defaults
  
  def defaults
    self.ranking ||= 0
  end
  
  
  # Returns the articles that are indexed with the term of the given text, sorted by the ranking
  def self.getRelevantArticles(text)

    term = Term.where(:text => text).first
    unless term.nil?
      results = where(:term_id => term.id).order(ranking: :desc)
    end
    results
  end

end
