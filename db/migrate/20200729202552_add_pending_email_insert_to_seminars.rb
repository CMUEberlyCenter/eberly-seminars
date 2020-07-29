class AddPendingEmailInsertToSeminars < ActiveRecord::Migration[5.1]
  def change
    add_column :seminars, :pending_email_insert, :string
  end
end
