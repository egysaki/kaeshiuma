class AddCourseTypeOnRaces < ActiveRecord::Migration[5.1]
  def change
    add_column :races, :course_type, :string
  end
end
