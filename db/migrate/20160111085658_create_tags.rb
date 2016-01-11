class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :body
      t.integer :question_id

      t.timestamps null: false
    end

    add_index :tags, :question_id
  end
end
