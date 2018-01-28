class JobsController < ApplicationController
    before_action :authenticate_user!, only: [:index, :new , :create, :edit, :update,:show,:destroy]    
    before_action :find_jobs_id, only: [:edit, :update,:show,:destroy]    
    def index
        @jobs = Job.all.ishidden.orderdescycreated.paginate(page: params[:page], per_page: 5)
    end
    def new
        @jobs = Job.new
    end
    def create
        @jobs = Job.new(jobs_params)
        @jobs.user = current_user
        if @jobs.save
            redirect_to jobs_path, notice: "#{@jobs.title}存檔成功"
        else
            render :new
        end        
    end    
    def edit
      
    end
    def update
        if @jobs.update(jobs_params)
            redirect_to jobs_path, notice: "#{@jobs.title}存檔成功"
        else
            render :edit
        end
    end
    def show
    end
    def destroy
        @jobs.destroy
        redirect_to jobs_path, alert: "#{@jobs.title}刪除成功"
    end
    private
    def jobs_params
       params.require(:job).permit(:title, :description,:wage_upper_bound,:wage_lower_bound,:contact_email)       
    end
    def find_jobs_id
        @jobs = Job.find(params[:id]) 
    end
end
