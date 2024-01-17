class CreateImages < ActiveRecord::Migration[7.1]
  def change
    create_table :images do |t|
      t.string :title
      t.string :url
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
