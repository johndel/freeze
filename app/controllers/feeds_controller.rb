class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.includes(:category).order("categories.position ASC, categories.name ASC, feeds.title ASC").page(params[:page]).per(100)
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
  end

  # GET /feeds/new
  def new
    @feed = Feed.new
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(feed_params)

    respond_to do |format|
      if @feed.save
        check_feed(@feed)
        format.html { redirect_to feeds_url, notice: 'Feed was successfully created.' }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to feeds_url, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def feed_working
    @feed = Feed.find(params[:id])
    @feed.update_from_feed
    redirect_to feeds_path
  end

  def working
    @feeds = Feed.all
    @feeds.each do |feed|
      @feed.save
    end
    redirect_to feeds_path
  end

  def fetch_articles
    Feed.all.each do |feed|
      feed.update_from_feed
    end
    redirect_to articles_path
  end

  def read_all
    feed = Feed.includes(:articles).find(params[:id])
    feed.articles.update_all(read_at: Time.now)
    head :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:category_id, :title, :feed_type, :htmlurl, :xmlurl, :comment)
    end
end
