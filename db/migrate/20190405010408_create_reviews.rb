class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :kind
      t.integer :point
      t.string :product_name
      t.integer :producing_area
      t.string :comment
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
