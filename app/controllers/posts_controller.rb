class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  before_action :authenticate_user!
  # GET /posts
  # GET /posts.json
  def index
    # @posts = Post.where(user_id: current_user.id)
    # 上はユーザーで絞り込んだもの　下はユーザーデータを含んだ全てのもの
    # @posts = Post.all
    # render json: @posts, include: [:user]
    # 最終形態 絞り込んだ後にuserのデータを渡す
    @posts = Post.where(user_id: current_user.id).includes(:user)
    render json: @posts, include: [:user]
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    render json: @post, include: [:user]
  end

  # POST /posts
  # POST /posts.json
  def create
    user = User.find_by(email: params[:uid])
    @post = Post.new(title: params[:title], body: params[:body], user_id: user.id)
    @post.save
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.update(post_params)
      # render :show, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.permit(:title, :body).merge(user: current_user)
    end
end
