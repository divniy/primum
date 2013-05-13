class CreateTagCategories < ActiveRecord::Migration
  def change
    create_table :tag_categories do |t|
      t.string :title
      t.string :type
      t.integer :position

      t.timestamps
    end

    add_index :tag_categories, :position, unique: true
  end
end
