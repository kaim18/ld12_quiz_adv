class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.integer :score
      t.timestamps null: false
    end
  end
end
