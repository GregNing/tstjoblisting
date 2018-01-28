# == Schema Information
#
# Table name: jobs
#
#  id               :integer          not null, primary key
#  title            :string
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  wage_upper_bound :integer
#  wage_lower_bound :integer
#  contact_email    :string
#

class Job < ApplicationRecord
    belongs_to :user
    has_many :resumes
    validates :title, :description, presence: { message: "必填項目" } 
    validates :contact_email, email_format: { :message => '請使用Email格式好方便做聯繫' }
    validates :wage_upper_bound, numericality: { greater_than: 0, message: '必須為數字，且大於0'}    
    validates :wage_lower_bound, numericality: { greater_than: 0, message: '必須為數字，且大於0' }
    scope :orderdescycreated, ->{ order('created_at DESC') }
    scope :descbywage_lower_bound, ->{ order('wage_lower_bound DESC') }
    scope :descbywage_upper_bound, ->{ order('wage_upper_bound DESC') }
    scope :ishidden, ->{ where(is_hidden: false) }    
    def to_publish
        self.is_hidden = false
        self.save
    end    
     def to_hide
        self.is_hidden = true
        self.save
    end
end
