class ChangeColumnActiveStatusOnHorses < ActiveRecord::Migration[5.1]
  def change
    change_column :horses, :active_status, :string, null: false
  end
end
