class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :category_find, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    @user = current_user
    @categories = policy_scope(Category)
    @categories = Category.all.order('created_at DESC')
    authorize Category
  end

  def new
    @user = current_user
    @category = Category.new
    authorize @category # Vérifie l'autorisation via Pundit
  end

  def create
    @category = Category.new(category_params)
    authorize @category # Vérifie l'autorisation via Pundit
    if @category.save
      redirect_to  categories_path(@category), notice: 'Categorie créée!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find(params[:id])
    @user = current_user
    authorize @category # Vérifie l'autorisation via Pundit
  end

  def edit
    # On récupère l'id avec before_action
    authorize @category
  end

  def update
    authorize @category
    @user = current_user
    if @category.update(category_params)
      redirect_to categories_path, :notice => "Catégorie a été mis à jour."
    else
      redirect_to categories_path, :alert => "Impossible de mettre à jour la catégorie."
    end
  end

  def destroy
    # On récupère l'id avec before_action
    # On supprime l'enregistrement avec l'id dans la BdD
    authorize @category
    @category.destroy
    # On redirige vers la page index
    redirect_to categories_path, status: :see_other
  end

  private

  def category_params
    params.require(:category).permit(:nom)
  end

  def category_find
    @category = Category.find(params[:id])
    @user = current_user
  end
end
