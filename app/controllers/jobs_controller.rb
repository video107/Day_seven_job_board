class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  def index
    if params[:cid].blank?
      @jobs = Job.all.order("created_at DESC")
    else
      @category = Category.find(params[:cid])
      @jobs = @category.jobs
    end
  end

  def show
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(jobs_param)
    if @job.save!
      redirect_to @job
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @job.update(jobs_param)
      redirect_to @job
    else
      render "edit"
    end
  end

  def destroy
    @job.destroy
    redirect_to root_path
  end

  private

  def jobs_param
    params.require(:job).permit(:title,:description,:company,:url,:category_id)
  end

  def set_job
    @job = Job.find(params[:id])
  end

end
