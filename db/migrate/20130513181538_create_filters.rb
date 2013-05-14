class CreateFilters < ActiveRecord::Migration
  def change
    create_table :filters do |t|
      t.string :title
      t.string :type
      t.string :position

      t.timestamps
    end

    add_index :filters, :position, unique: true
  end
end
