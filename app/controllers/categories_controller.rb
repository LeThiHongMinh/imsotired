class CategoriesController < ActionController::API
  before_action :set_category, only: [:show, :update, :destroy]

  # GET /categories or /categories.json
  def index
    @categories = Category.all
    @discussions = Discussion.all.order(created_at: :desc)

    render json: { categories: @categories, discussions: @discussions }
  end

  # GET /categories/1 or /categories/1.json
  def show
    @discussions = @category.discussions
    @categories = Category.all

    render json: { category: @category, discussions: @discussions }
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    render json: { message: 'Category was successfully destroyed.' }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:category)
  end
end
