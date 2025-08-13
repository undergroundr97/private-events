class AddPrivacyToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :privacy, :boolean, default: true
  end
end
