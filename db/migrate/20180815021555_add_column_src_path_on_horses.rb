class AddColumnSrcPathOnHorses < ActiveRecord::Migration[5.1]
  def change
    add_column :horses, :src_path, :string
  end
end
