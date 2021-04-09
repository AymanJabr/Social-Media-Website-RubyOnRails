# rubocop:disable Lint/ShadowingOuterLocalVariable
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships

  # def friends
  #   friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
  #   friends_array + inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
  #   friends_array.compact
  # end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |friendship| friendship.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def reject_friend(user)
    friendship = inverse_friendships.find { |friendship| friendship.user == user }
    friendship.confirmed = false
    friendship.save
  end

  def remove_friend(user)
    reject_friend(user)
  end

  def send_friend_request(user)
    friendship = inverse_friendships.find { |friendship| friendship.user == user }
    friendship.status = 'pending'
    friendship.save
  end

  def get_friend_request(user)
    friendship = inverse_friendships.find { |friendship| friendship.user == user }
    friendship.status = 'to_confirm'
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
# rubocop:enable Lint/ShadowingOuterLocalVariable
