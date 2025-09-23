class PollOption < ApplicationRecord
  belongs_to :poll
  has_many :poll_votes, dependent: :destroy
  
  validates :option_text, presence: true, length: { maximum: 100 }
  
  def vote_percentage
    return 0 if poll.total_votes == 0
    (poll_votes.count.to_f / poll.total_votes * 100).round(1)
  end
end
