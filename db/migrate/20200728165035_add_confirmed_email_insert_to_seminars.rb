class AddConfirmedEmailInsertToSeminars < ActiveRecord::Migration[5.1]
  def change
    add_column :seminars, :confirmed_email_insert, :string
  end
end
