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

  def show
  end

  def edit
  end

  def destroy
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
end
