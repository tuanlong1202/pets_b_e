class User < ApplicationRecord
    
    has_secure_password

    validates :user_name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true

    has_many :pets, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :ratings, dependent: :destroy
end
