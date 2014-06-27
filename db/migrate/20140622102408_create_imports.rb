class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.text :raw_data

      t.timestamps
    end
  end
end
