class AddEpisodeAndSeasonToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :episode, :integer
    add_column :subscriptions, :season, :integer
  end
end
