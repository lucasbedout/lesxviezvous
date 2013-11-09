class PostsController < ApplicationController

  # encoding: UTF-8
  # Posts status : 0 => moderation, 1 => ok, to validate, 2 => fake, to validate, 3 => posted, 4 => fake posted
  # GET /posts
  # GET /posts.json
  def index
    if current_user
      @posts = current_user.timeline(:last_shown_obj_id => nil, :limit => 10, :for_user => nil)
    else
      @posts = Post.where(status: '3').order('created_at DESC').all;
    end

    respond_to do |format|
      format.html 
      format.json { render json: @posts }
    end
  end

  def index_fakes
    @posts = Post.where(status: '4').all

    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    if @post.status != 3
      redirect_to root_path, :flash => { :error => "Le post n'existe pas ou n'est pas encore valide"}
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @post }
      end
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    if (@post.created_at.to_time + 2.days) < Time.now
      redirect_to post_path(@post), :flash => { :error => "Trop tard, les 48h sont depassees !" }
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post]) # params : content, category, source
    if !params[:community].blank?
      @post.category_id = Community.find(params[:community]).category_id
    end

    @post.user_id = current_user.id
    @post.users_ids_who_favorite_it = '[]'
    @post.users_ids_who_comment_it = '[]'
    @post.users_ids_who_reblog_it = '[]'
    @post.communities_ids = '[]'

    respond_to do |format|
      if @post.save
        if !params[:community].blank?
          current_user.send_post_to_community :post => @post, :to_community => Community.find(params[:community])
          format.html { redirect_to Community.find(params[:community]), notice: 'Post was successfully created.' }
        end
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to :back, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def vote
    @post = Post.find(params[:post_id])

    case params[:vote]
    when '0'
      @post.downvotes += 1
    when '1'
      @post.upvotes += 1
    else
      @post.fakevotes += 1
    end
    @post.save!
    unless @post.status != 0
      if @post.upvotes > 100 && (@post.downvotes * 100 /  @post.upvotes) < 30
        @post.status = 1 
        respond_to do |format|
          @post.save!
          format.js { render 'moderate' }
        end
      elsif @post.upvotes > 100 && (@post.downvotes * 100 / @post.fakevotes) < 30
        @post.status = 2
        respond_to do |format|
          @post.save!
          format.js { render 'moderate' }
        end
      end
    else
      # Render javascript to change vote text to "Vote pris en compte"
      respond_to do |format|
        format.js 
      end
    end
  end

  def moderate
    if !Post.where(status: '0').all.blank?
      @post = Post.where(status: '0').sample
    else
      redirect_to root_path, :flash => { :error => 'Aucun post a moderer'}
    end
  end

  def validate
    @post = Post.find(params[:post_id])

    if params[:validate] == '1' and @post.status == 1
      @post.status = 3
    elsif params[:validate] == '1' and @post.status == 2
      @post.status = 4
    else
      # @post.destroy
    end
    # Render javascript to change vote text to "Vote pris en compte"
      respond_to do |format|
        @post.save!
        format.js { render 'validate' }
      end 

  end

  def favorite 
    @post = Post.find(params[:post_id])
    if current_user.favorite? @post
      current_user.unfavorite @post
    else
      current_user.favorite @post
    end

    respond_to do |format|
      @post.save!
      format.js { render 'favorite' }
    end 
  end

  def reblog 
    @post = Post.find(params[:post_id])
    if current_user.reblog? @post
      current_user.unreblog @post
    else
      current_user.reblog @post
    end

    respond_to do |format|
      @post.save!
      format.js { render 'reblog' }
    end 
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    unless @post.status == 0
      redirect_to post_path(@post), :flash => { :error => "Trop tard, votre information est en attente de validation !" }
    end
    @post.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private

end
