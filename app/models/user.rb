class User < ApplicationRecord
  has_many :followers

  validates :name, :username, presence: true
  validates :name, uniqueness: true

  def follow_user(user:)
    follow = followers.new(name: user.name)
    follow.save
  end

  def unfollow_user(user:)
    unfollow = followers.find_by(name: user.name)
    unfollow.destroy
  end
end
