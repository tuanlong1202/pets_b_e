class Comment < ApplicationRecord

    validates :content, presence: true
    validates :user_id, numericality: { only_integer: true }
    validates :pet_id, numericality: { only_integer: true }

    belongs_to :user
    belongs_to :pet
end
