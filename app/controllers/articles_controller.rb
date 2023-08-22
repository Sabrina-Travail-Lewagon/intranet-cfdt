class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :destroy, :update]
  skip_before_action :authenticate_user!
  # after_action :verify_authorized

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
    sanitized_content = sanitize_content(params_article[:content])
    @article = Article.new(params_article.merge(content: sanitized_content))
    @article.user = current_user # Pour éviter l'erreur l'user n'existe pas
    authorize @article # Vérifie l'autorisation via Pundit
    if @article.save
      redirect_to articles_path(@article), notice: 'Article créé!'
    else
      flash.now[:alert] = "Impossible de créer l'article."
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'Article a bien été supprimé.'
  end

  def update
    sanitized_content = sanitize_content(params_article[:content])
    if @article.update(params_article.merge(content: sanitized_content))
      redirect_to articles_path, :notice => "Article mis à jour."
    else
      render :edit, :alert => "Impossible de mettre à jour l'article."
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
    @user = current_user # Pour que le header puisse s'afficher avec le login
    authorize @article
  end

  def params_article
    params.require(:article).permit(:title, :content, images: [], category_ids: [])
  end

  def sanitize_content(content)
    allowed_tags = %w(a b i em u h1 h2 h3 h4 h5 h6 p img iframe br ul ol li video source)
    # allowed_attributes: les attributs width et height que l'utilisateur définit dans l'éditeur de texte
    # ne seront pas supprimés par sanitizer,
    # et les images afficheront donc la taille que l'utilisateur a spécifiée
    allowed_attributes = %w(href src alt target frameborder allowfullscreen type rel width height)
    ActionController::Base.helpers.sanitize(content, tags: allowed_tags, attributes: allowed_attributes)
  end
end
