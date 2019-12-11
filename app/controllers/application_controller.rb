
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  post '/articles' do
    article = Article.new(params)
    article.save
    redirect to "articles/#{Article.last.id}"
  end

  get '/articles/new' do
    erb :new
  end


  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save

    redirect to "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    article = Article.find(params[:id])
    article.destroy
  end
end
