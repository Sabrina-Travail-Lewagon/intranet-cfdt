class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :destroy]
  skip_before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @user = current_user
    # Policy_scope  utilisée pour appliquer la politique de portée (policy scoping) aux collections d'enregistrements
    # policy_scope(Article) applique la politique de portée à la collection d'articles,
    # en fonction des autorisations définies dans votre politique ArticlePolicy
    @articles = policy_scope(Article).order('created_at DESC')
    authorize @articles
  end

  def new
    @user = current_user
    @article = Article.new
    authorize @article
  end

  def create
    @user = current_user
    @article = Article.new(params_article)
    @article.user = current_user
    authorize @article # Vérifie l'autorisation via Pundit
    if @article.save
      redirect_to articles_path(@article), notice: 'Article créé!'
    else
      console
      flash.now[:alert] = "Impossible de créer l'article."
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
    authorize @article
  end

  def edit
  end

  def destroy
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def params_article
    params.require(:article).permit(:title, :content)

  end
end
