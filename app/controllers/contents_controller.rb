class ContentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @contents = Content.all
  end

  def new
    @needs_trix = true
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    if @content.save
      flash[:success] = 'content created successfully! :D'
      redirect_to edit_content_path(@content)
    else
      flash[:alert] = 'content failed to create :('
      render 'new'
    end
  end

  def edit
    @needs_trix = true
    @content = Content.find(params[:id])
  end

  def update
    @content = Content.find(params[:id])
    if @content.update(content_params)
      flash[:success] = 'content updated successfully! :D'
      redirect_to edit_content_path(@content)
    else
      flash[:alert] = 'content failed to update :('
      render 'edit'
    end
  end

  private

  def content_params
    params.require(:content).permit(:identifier, :body)
  end
end
