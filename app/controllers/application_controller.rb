require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  post '/posts' do
    @post = Post.create(name:params[:name],content:params[:content])
    redirect '/posts'
  end

  get '/posts/:id' do
    post_id = params[:id].to_i
    if Post.pluck(:id).include?(post_id)
      @post = Post.find(params[:id])
      erb :show
    else
      redirect '/posts'
    end
  end

  patch '/posts/:id' do
    post_id = params[:id].to_i
    if Post.pluck(:id).include?(post_id)
      @post = Post.find(params[:id])
      @post.update(name:params[:name],content:params[:content])
      erb :show
    else
      redirect '/posts'
    end
  end

  get '/posts/:id/edit' do
    post_id = params[:id].to_i
    if Post.pluck(:id).include?(post_id)
      @post = Post.find(params[:id])
      erb :edit
    else
      redirect '/posts'
    end
  end

  delete '/posts/:id/delete' do
    post_id = params[:id].to_i
    if Post.pluck(:id).include?(post_id)
      @post = Post.find(params[:id])
      @post.destroy
      erb :delete
    else
      redirect '/posts'
    end
  end


end
