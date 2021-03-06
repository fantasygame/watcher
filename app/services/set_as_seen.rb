class SetAsSeen
  def initialize(user, tv, episodes = [])
    @user = user
    @tv = tv
    @episodes = episodes
  end

  def call
    @episodes = @tv.episodes if @episodes.empty?
    @episodes.each do |episode|
      unless @user.seen?(@tv, episode)
        View.create(tv_id: @tv.id, episode_id: episode.id, user: @user)
      end
    end
  end
end
