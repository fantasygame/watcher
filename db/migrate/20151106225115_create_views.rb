class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :tv_id
      t.integer :episode_id

      t.timestamps null: false
    end
  end
end
