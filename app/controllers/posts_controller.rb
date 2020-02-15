class PostsController < ApplicationController
  # ensure that our view has access to the controller's params hash
  # SHOULD NOT HAVE VIEW READING PARAMS, WHICH WE HAD TO ALLOW FROM CONTROLLER
  # helper_method :params

  def index
    # provide a list of authors to the view for the filter control
    @authors = Author.all
    
    # filter the @posts list based on user input
    if !params[:author].blank?
      @posts = Post.by_author(params[:author]) #author_id taken
    elsif !params[:date].blank?
      if params[:date] == "Today"
        @posts = Post.from_today
      else 
        # put where("created_at <?", Time.zone.today.beginning_of_day) to model
        @posts = Post.old_news
      end
    else
      # if no filters are applied, show all posts
      @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end
end
