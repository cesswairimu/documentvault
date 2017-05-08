class ChangeContentField < ActiveRecord::Migration[5.0]
  def change
   rename_column :documents, :content, :attachment
   change_column :documents, :attachment, :string
  end
end
