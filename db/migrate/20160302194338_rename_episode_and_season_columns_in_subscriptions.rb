class RenameEpisodeAndSeasonColumnsInSubscriptions < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :episode, :episode_number
    rename_column :subscriptions, :season, :season_number
  end
end
