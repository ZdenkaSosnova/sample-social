class Poll < ApplicationRecord
  belongs_to :user
  has_many :poll_options, dependent: :destroy
  has_many :poll_votes, through: :poll_options
  
  accepts_nested_attributes_for :poll_options, reject_if: :all_blank, allow_destroy: true
  
  validates :question, presence: true, length: { maximum: 200 }
  validate :minimum_options
  
  
  
  def total_votes
    poll_votes.count
  end
  
  def voted_by?(user)
    return false unless user
    poll_votes.joins(:poll_option).where(user: user).exists?
  end
  
  def user_vote(user)
    return nil unless user
    poll_votes.joins(:poll_option).find_by(user: user)
  end
  
  private
  
  def minimum_options
    valid_options = poll_options.reject { |option| option.option_text.blank? }
    if valid_options.size < 2
      errors.add(:base, "Poll must have at least 2 options")
    end
  end
end
