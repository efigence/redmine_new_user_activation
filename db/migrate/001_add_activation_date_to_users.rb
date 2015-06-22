class AddActivationDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_date, :datetime, null: true
  end
end
