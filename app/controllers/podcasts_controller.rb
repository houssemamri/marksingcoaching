class PodcastsController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show]
  before_action :set_podcast, only: %i[show edit update destroy]
  # defaults resource_class: Podcast.friendly

  def index
    @podcasts = Podcast.all
    @needs_datatables = true
  end

  def show
    @podcast = Podcast.friendly.find(params[:id])
    @related_podcasts = [] # Podcast.tagged_with(@podcast.tag_list) - [@podcast]
  end

  def new
    @podcast = Podcast.new
    @needs_trix = true
  end

  def edit
    @needs_trix = true
  end

  def create
    @podcast = Podcast.new(podcast_params)
    if @podcast.save
      flash[:success] = 'podcast created successfully! :D'
      redirect_to edit_podcast_path(@podcast)
    else
      flash[:alert] = 'podcast failed to create :('
      render 'new'
    end
  end

  def update
    if @podcast.update(podcast_params)
      flash[:success] = 'podcast updated successfully! :D'
      redirect_to edit_podcast_path(@podcast)
    else
      flash[:alert] = 'podcast failed to update :('
      render 'edit'
    end
  end

  def destroy
    if @podcast.destroy
      flash[:success] = 'podcast deleted successfully! :D'
      redirect_to podcasts_path
    end
  end
  
  private
 
  def set_podcast
    @podcast = Podcast.friendly.find(params[:id])
  end

  def podcast_params
    params.require(:podcast).permit(:title, :description, :published_on, :libsyn_id, :content)
  end
end
