class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    # Grab all posts which are originals for its thread
    @posts = Post.where(parent_post_id: nil).order(votes_count: :desc, created_at: :desc)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    if !user_signed_in?
      flash[:notice] = "You must sign in to post."
      redirect_to posts_path
    else
      @post = Post.new
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote
    @post = Post.find(params[:id])
    # Should break this sign in check into helper
    if !user_signed_in?
      flash[:notice] = "You must be signed in to vote."
      redirect_to root_path
    elsif current_user.followed_posts.include? @post
      flash[:notice] = "You have already voted on this post."
      redirect_to posts_path
    else
      if params[:vote] == "true"
        Like.create(user_id: current_user.id, post_id: @post.id, positive: true)
        new_vote_count = @post.votes_count + 1
      elsif params[:vote] == "false"
        Like.create(user_id: current_user.id, post_id: @post.id, positive: true)
        new_vote_count = @post.votes_count - 1
      end
      respond_to do |format|
        if @post.update(votes_count: new_vote_count)
          format.html { redirect_to posts_path, notice: 'Your vote has been counted.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { redirect_to posts_path, notice: 'There was an error and your vote was not counted.' }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :votes_count, :user_id, :parent_post_id)
    end
end
