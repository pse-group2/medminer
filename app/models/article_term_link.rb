class ArticleTermLink < ActiveRecord::Base

  belongs_to :article
  belongs_to :term
  
  # Returns the articles that are indexed with the term of the given text, sorted by the ranking
  def self.getRelevantArticles(text)
    articles = Array.new

    Term.where(:text => text).each do |term|
      where(:term_id => term.id).order(:ranking).each do |row|
        article_id = row.article_id
        article = Article.find_by_id(article_id)
        articles.push(article)
      end

    end

    articles
  end

end
