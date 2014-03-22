class TextMiningController < ApplicationController
  def search
  end

  def results
    text = params[:search_text]
    #client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "toor", :database => "dewiki")

    @results = ArticleTermLink.getRelevantArticles(text)
  end
end
