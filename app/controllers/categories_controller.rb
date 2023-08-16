class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @categories = policy_scope(Category)
    @user = current_user
    @categories = Category.all.order('created_at DESC')
  end

  def new
    @user = current_user
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to  categories_path(@category), alert: 'Categorie créée!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:nom)
  end
end
