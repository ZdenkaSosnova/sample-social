class Micropost < ApplicationRecord
  belongs_to       :user

  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  
  VISIBILITY_OPTIONS = %w[public followers_only].freeze
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :visibility, inclusion: { in: VISIBILITY_OPTIONS }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size: { less_than: 5.megabytes,
                              message:   "should be less than 5MB" }
  
  scope :public_posts, -> { where(visibility: "public") }
  scope :followers_only, -> { where(visibility: "followers_only") }
  
  def public?
    visibility == "public"
  end
  
  def followers_only?
    visibility == "followers_only"
  end
  
  def visible_to?(viewing_user)
    return true if public?
    return true if viewing_user&.admin?
    return true if viewing_user == user
    return true if viewing_user && user.followers.include?(viewing_user)
    false
  end
end
