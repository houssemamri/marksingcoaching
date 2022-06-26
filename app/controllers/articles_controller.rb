class ArticlesController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show]
  before_action :set_article, only: %i[show edit update destroy]
  # defaults resource_class: Article.friendly

  def index
    @articles = Article.includes([main_image_attachment: :blob]).where(published: true)
  end

  def show
    @article = Article.friendly.find(params[:id])
    @related_articles = [] # Article.tagged_with(@article.tag_list) - [@article]
  end

  def new
    @article = Article.new
    @needs_trix = true
  end

  def edit
    @needs_trix = true
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = 'article created successfully! :D'
      redirect_to edit_article_path(@article)
    else
      flash[:alert] = 'article failed to create :('
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = 'article updated successfully! :D'
      redirect_to edit_article_path(@article)
    else
      flash[:alert] = 'article failed to update :('
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = 'article deleted successfully! :D'
      redirect_to articles_path
    end
  end

  private

  def set_article
    @article = Article.friendly.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :slug, :main_image, :headline, :description,
                                    :content, :user_id, :tag_list, :published, :restricted,
                                    :tldr, :time_to_read, :featurable, :main_image_credits)
  end
end
