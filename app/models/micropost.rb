class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: "格式不支持" },
            size: { less_than: 5.megabytes,
                    message: "大小5MB以内" }

  def resize_image
    image.variant(resize_to_limit: [250, 250])
  end
end
