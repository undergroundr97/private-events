class AddStatusToInvites < ActiveRecord::Migration[8.0]
  def change
    add_column :invites, :status, :integer
  end
end
