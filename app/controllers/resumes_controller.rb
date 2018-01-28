class ResumesController < ApplicationController
  before_action :authenticate_user!

  def new
    @jobs = Job.find(params[:job_id])
    @resume = Resume.new
  end

  def create
    @jobs = Job.find(params[:job_id])
    @resume = Resume.new(resume_params)
    @resume.job = @jobs
    @resume.user = current_user

    if @resume.save
      flash[:notice] = "成功提交履历"
      redirect_to job_path(@jobs)
    else
      render :new
    end
  end

  private

  def resume_params
    params.require(:resume).permit(:content, :attachment)
  end
end
