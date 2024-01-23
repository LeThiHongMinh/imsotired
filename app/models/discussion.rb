class Discussion < ApplicationRecord
    belongs_to :category
    belongs_to :user 
    has_many :comments, dependent: :destroy
    validates :title, :content, presence: true
end