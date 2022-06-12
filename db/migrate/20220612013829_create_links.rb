class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :url
      t.string :shorten_code
      t.string :clicks_count
      t.string :integer
      t.references :user

      t.timestamps
    end
  end
end
