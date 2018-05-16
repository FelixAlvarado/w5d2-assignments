class PostsController < ApplicationController
  before_action :require_author, only: [:edit, :update]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    new_id = params[:post][:new_sub_id]

    if @post.update(post_params)
      PostSub.create(post_id: @post.id, sub_id: new_id)
      redirect_to edit_post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
  end

  def create
    @post = Post.new(post_params)
    @post.sub_id = params[:sub_id]
    @post.author_id = current_user.id
     if @post.save

       PostSub.create(post_id:@post.id, sub_id:@post.sub_id)
     end
    flash[:errors] = @post.errors.full_messages
    redirect_to sub_url(@post.sub_id)


  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

  def require_author
    post = Post.find(params[:id])
    redirect_to post_url(post) unless current_user.id == post.author_id
  end
end
