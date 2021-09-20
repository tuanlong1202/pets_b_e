class User < ApplicationRecord
    
    has_secure_password

    validates :user_name, presence: true
    validates :email , uniqueness: true
    validates :password_digest, length: {in: 6..20}

    has_many :pets, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :ratings, dependent: :destroy
end
