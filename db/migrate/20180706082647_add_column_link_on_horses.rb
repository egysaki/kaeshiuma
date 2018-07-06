class AddColumnLinkOnHorses < ActiveRecord::Migration[5.1]
  def change
    add_column :horses, :link, :string, null: false
  end
end
