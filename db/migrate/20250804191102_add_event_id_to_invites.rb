class AddEventIdToInvites < ActiveRecord::Migration[8.0]
  def change
    add_reference :invites, :event, null: false, foreign_key: true
  end
end
