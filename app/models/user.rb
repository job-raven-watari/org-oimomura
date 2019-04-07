class User < ApplicationRecord

  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :profile, length: { maximum: 200 }
  has_secure_password
  
  has_many :reviews
  has_many :likes, dependent: :destroy
  has_many :likes_reviews, through: :likes, source: :review
  
  def like(review)
      self.likes.find_or_create_by(review_id: review.id)
  end
  
  def unlike(review)
    like = self.likes.find_by(review_id: review.id)
    like.destroy if like
  end
  
  def liking?(review)
    self.likes_reviews.include?(review)
  end
end
