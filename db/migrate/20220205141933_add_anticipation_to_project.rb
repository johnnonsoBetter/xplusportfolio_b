class AddAnticipationToProject < ActiveRecord::Migration[6.0]
  def change
    add_reference :projects, :anticipation, null: true, foreign_key: true
  end
end
