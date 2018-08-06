class ChangeNullSettingOnGrade < ActiveRecord::Migration[5.1]
  def change
    change_column_null :races, :grade, true
  end
end
