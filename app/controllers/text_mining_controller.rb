class TextMiningController < ApplicationController
  def search
   @text = params[:search_text].nil? ? "" :  params[:search_text]
   client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "team2", :database => "dewiki")
   
   @text = @text + Article.find(1).name
  end

  def results
  end
end
