class DiscussionsController < ActionController::API
  before_action :set_discussion, only: [:show, :edit, :update, :destroy]
  before_action :find_categories, only: [:index, :show, :new, :edit]
  before_action :authorized, except: [:index, :show]

  # GET /discussions or /discussions.json
  def index
    @discussions = Discussion.all.order(created_at: :desc)
    render json: { discussions: @discussions }
  end

  # GET /discussions/1 or /discussions/1.json
  def show
    @comments = @discussion.comments
    render json: { discussion: @discussion, comments: @comments }
  end

  # GET /discussions/new
  def new
    @discussion = current_user.discussions.build
  end

  # POST /discussions or /discussions.json
  def create
    @discussion = current_user.discussions.build(discussion_params)

    if @discussion.save
      render json: { discussion: @discussion, notice: 'Discussion was successfully created.' }, status: :created
    else
      render json: { errors: @discussion.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /discussions/1 or /discussions/1.json
  def update
    if @discussion.update(discussion_params)
      render json: { discussion: @discussion, notice: 'Discussion was successfully updated.' }
    else
      render json: { errors: @discussion.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /discussions/1 or /discussions/1.json
  def destroy
    @discussion.destroy
    render json: { message: 'Discussion was successfully deleted.' }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  def find_categories
    @categories = Category.all.order(created_at: :desc)
  end

  # Only allow a list of trusted parameters through.
  def discussion_params
    params.require(:discussion).permit(:title, :content, :category_id)
  end
end
