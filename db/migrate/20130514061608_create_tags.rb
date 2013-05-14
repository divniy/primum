class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.belongs_to :filter, index: true
      t.integer :position

      t.timestamps
    end
  end
end
