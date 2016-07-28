class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :link
      t.string :tag
      t.string :department
      t.references :user, foreign_key: true

      t.timestamps
    end
      add_index :documents, [:user_id, :created_at]
  end
end
