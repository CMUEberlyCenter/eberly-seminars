class AddNameCacheToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :name_cache, :string
  end
end
