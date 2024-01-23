class User < ApplicationRecord
    validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum:6, maximum:30}
    has_many :discussions, dependent: :destroy
    has_many :categories, through: :discussions
end