class Comment < ApplicationRecord
    belongs_to :discussion
    belongs_to :user
    validates :comment, presence: true
end