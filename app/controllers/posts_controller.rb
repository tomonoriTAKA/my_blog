class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @q = Post.order(created_at: :desc).ransack(params[:q])
    @posts = @q.result.page(params[:page]).per(2)

    @new_posts = Post.find_newest_article
  end

  def show
  end

  def new
    #インスタンス変数にPostの空のインスタンス生成
    @post = Post.new
  end

  def create
    # インスタンス変数に空枠(ストロングパラメータから取得した値が引数)を渡す
    @post = Post.new(post_params)
    # 保存
    @post.save
    # showにリダイレクト
    redirect_to "/posts/#{@post.id}"
  end

  def edit
  end

  def update
    # インスタンス変数をupdate(ストロングパラメータから取得した値が引数)
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    #destroy
    @post.destroy
    #indexにリダイレクト
    redirect_to "/"
  end

    private
    #ストロングパラメータを定義
    def post_params
      params.require(:post).permit(:title,:body,:category,)
    end

    def set_post
      @post = Post.find(params[:id])
    end


end
