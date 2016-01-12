class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :body
      t.integer :question_id
      t.integer :user_id
      t.float :tips
      t.integer :num_user_tips

      t.timestamps null: false
    end
  end
end
