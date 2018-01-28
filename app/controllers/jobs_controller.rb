class JobsController < ApplicationController
    before_action :authenticate_user!, only: [:index, :new , :create, :edit, :update,:show,:destroy]    
    before_action :find_jobs_id, only: [:edit, :update,:show,:destroy]    
    def index
        @jobs = 
        @jobs = case params[:order]
                when 'by_lower_bound'
                    Job.all.ishidden.descbywage_lower_bound.paginate(page: params[:page],per_page: 5)
                when 'by_upper_bound'
                    Job.all.ishidden.descbywage_upper_bound.paginate(page: params[:page],per_page: 5)
                else
                    Job.all.ishidden.orderdescycreated.paginate(page: params[:page], per_page: 5)
                end
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
        if @jobs.is_hidden
            flash[:warning] = "尚未開放"
            redirect_to root_path
        end
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
