class CourseModulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course_module, only: %i[show edit update destroy]
  before_action :authenticate_admin!, except: [:show]

  def index
    @course_modules = CourseModule.all
  end

  def show; end

  def edit; end

  def new
    @course_module = CourseModule.new
  end

  def create
    @course_module = CourseModule.new(course_module_params)
    if @course_module.save
      flash[:success] = 'course_module created successfully! :D'
      redirect_to edit_course_module_path(@course_module)
    else
      flash[:alert] = 'course_module failed to create :('
      render 'new'
    end
  end

  def update
    if @course_module.update(course_module_params)
      flash[:success] = 'course_module updated successfully! :D'
      redirect_to edit_course_module_path(@course_module)
    else
      flash[:alert] = 'course_module failed to update :('
      render 'edit'
    end
  end

  def destroy
    if @course_module.destroy
      flash[:success] = 'course_module deleted successfully! :D'
      redirect_to course_modules_path
    end
  end

  private

  def set_course_module
    @course_module = CourseModule.friendly.includes(:course).find(params[:id])
    @course = @course_module.course
  end

  def course_module_params
    params.require(:course_module).permit(:course_id, :name, :description, :content, :table_of_contents, :call_to_action, :vimeo_video_id)
  end
end
