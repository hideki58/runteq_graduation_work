class AddColumnToDiary < ActiveRecord::Migration[7.2]
  def change
    add_column :diaries, :date, :date
  end
end
