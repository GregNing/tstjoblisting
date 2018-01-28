class Admin::JobsController < ApplicationController
    before_action :authenticate_user!, only: [:index, :new , :create, :edit, :update,:show,:destroy,:publish,:hide] 
    before_action :find_jobs_id, only: [:edit, :update,:show,:destroy,:publish,:hide] 
    before_action :require_is_admin
    layout "admin"
    def index        
        @jobs = Job.all.orderdescycreated.paginate(page: params[:page], per_page: 5)
    end
    def new
        @jobs = Job.new
    end    
    def create
        @jobs = Job.new(jobs_params)
        @jobs.user = current_user
        if @jobs.save
            redirect_to admin_jobs_path, notice: "#{@jobs.title}新增成功"
        else
            render :new
        end
    end
    def edit        
    end
    def update
        if @jobs.update(jobs_params)
            redirect_to admin_jobs_path, notice: "#{@jobs.title}修改存檔成功"
        else
            render :edit
        end
    end

    def destroy
        @jobs.destroy
        redirect_to admin_jobs_path, alert: "#{@jobs.title}刪除成功"
    end

    def publish
        @jobs.to_publish
        
         redirect_back fallback_location: root_path , notice: "#{@jobs.title}發布成功"  
    end
    def hide
        @jobs.to_hide                
        flash[:warning] = "#{@jobs.title}隱藏成功"
         redirect_to admin_jobs_path
    end
    private
    def find_jobs_id
        @jobs = Job.find(params[:id])
    end
    def jobs_params
        params.require(:job).permit(:title, :description,:wage_upper_bound,:wage_lower_bound,:contact_email, :is_hidden)       
    end
    def require_is_admin
        if !current_user.admin?
            redirect_to root_path, alert: "您尚未登入"
        end
    end
end
