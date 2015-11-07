class SetAsUnseen
  attr_reader :user, :tv, :episodes

  def initialize(user, tv, episodes = [])
    @user = user
    @tv = tv
    @episodes = episodes
  end

  def call
    episodes = tv.episodes if @episodes.empty?
    episodes.each do |episode|
      if user.seen?(episode)
        View.where(tv_id: @tv.id, episode_id: episode.id, user: user).destroy_all
      end
    end
  end
end
