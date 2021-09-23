class Pet < ApplicationRecord
    
    validates :name, presence: true
    validates :image, length: {maximum: 255}
    validates :user_id, numericality: { only_integer: true }

    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :ratings, dependent: :destroy
end
