class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.integer :point
      t.integer :user_id
      t.integer :pet_id

      t.timestamps
    end
  end
end
