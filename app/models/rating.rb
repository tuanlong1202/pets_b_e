class Rating < ApplicationRecord

    validates :point, numericality: { in: 1..5 }
    validates :user_id, numericality: { only_integer: true }
    validates :pet_id, numericality: { only_integer: true }

    belongs_to :user
    belongs_to :pet
end
