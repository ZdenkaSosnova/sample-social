module PollsHelper
  def can_vote_on_poll?(poll)
    current_user == poll.user || current_user.following?(poll.user)
  end
end
