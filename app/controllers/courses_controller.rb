class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: %i[new edit update destroy]

  def index
  end

  def show
  end

  def edit; end

  def new
    @course = Course.new
  end

  def create
    @course = course.new(course_params)
    if @course.save
      flash[:success] = 'Course created successfully! :D'
      redirect_to edit_course_path(@course)
    else
      flash[:alert] = 'Course failed to create :('
      render 'new'
    end
  end

  def update
    if @course.update(course_params)
      flash[:success] = 'Course updated successfully! :D'
      redirect_to edit_course_path(@course)
    else
      flash[:alert] = 'Course failed to update :('
      render 'edit'
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = 'Course deleted successfully! :D'
      redirect_to courses_path
    end
  end

  private

  def set_course
    @course = Course.friendly.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :published,
                                   :vimeo_video_id, :slug, :description, :call_to_action,
                                   :cover, :tag_list)
  end
end
