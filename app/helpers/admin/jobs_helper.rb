module Admin::JobsHelper
    def render_jobs_status(job)
        if job.is_hidden?
            content_tag(:span, '' , class: 'fa fa-lock')
        else
            content_tag(:span, '' , class: 'fa fa-globe')
        end
    end
    def render_jobs_description(job)
        simple_format(job.description)        
    end
end
