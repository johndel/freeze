class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :read_all]
  before_action :set_categories, only: [:index, :sort, :sort_update]
  # GET /categories
  # GET /categories.json
  def index
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sort
  end

  def sort_update
    params[:category].each_with_index do |id, index|
      category = @categories.select {|category| category.id == id.to_i}.first
      category.position = index+1
      category.save
    end
    render nothing: true
  end

  def read_all
    Article.where(feed_id: @category.feeds.map(&:id), read_at: nil).update_all(read_at: Time.now)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.includes(feeds: :articles).find(params[:id])
    end

    def set_categories
      @categories = Category.includes(:feeds).order("position ASC, name ASC")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end
end
