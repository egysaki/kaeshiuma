class ChangeNullSettingOnHorses < ActiveRecord::Migration[5.1]
  def change
    change_column_null :horses, :hair_color_type, true
    change_column_null :horses, :sex, true
    change_column_null :horses, :age, true
    change_column_null :horses, :active_status, true
    change_column_null :horses, :birth_day, true
    change_column_null :horses, :link, true
  end
end
