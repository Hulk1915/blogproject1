class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.integer :value
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
