class PostsController < ApplicationController
  # http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]


  def index
    @post = Post.all

  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])

  end


  def show
    @post = Post.find(params[:id])


  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else

      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: 'Пост успешно удален.'
  end


  # def create
  #   # render plain: params[:post].inspect

  #   @post = Post.new(post_params)

  #   if (@post.save)
  #     redirect_to @post
  #   else

  #     render 'new'
  #   end

  # end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post }
        format.json { render json: { success: true, redirect: post_path(@post) } }
      else
        format.html { render 'new' }
        format.json { render json: { success: false, errors: @post.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end


  private def post_params
  params.require(:post).permit(:title, :body)

  end
end
