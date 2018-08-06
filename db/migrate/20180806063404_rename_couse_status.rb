class RenameCouseStatus < ActiveRecord::Migration[5.1]
  def change
    rename_column :race_results, :corse_status, :course_status
  end
end
