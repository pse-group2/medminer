class TextMiningController < ApplicationController
  def search
  end

  def results
    text = params[:search_text]
    #client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "toor", :database => "dewiki")

    #@results = ArticleTermLink.getRelevantArticles(text)
    @results = fullTextSearch(text)
  end
  
  def fullTextSearch(text)
    Text.find_by_sql [ "SELECT *, MATCH(content) AGAINST ('#{text}') AS score FROM text WHERE MATCH(content) AGAINST('#{text}') ORDER BY score DESC" ]
  end
  
end
