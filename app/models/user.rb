# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: {case_sensitive: false}

  has_many :photos, dependent: :delete_all
  has_many :comments, dependent: :delete_all

  has_many :requested_friendships, foreign_key: :invitee_id, class_name: "Friendship"
  has_many :requesters, through: :requested_friendships

  has_many :invited_friendships, foreign_key: :requester_id, class_name: "Friendship"
  has_many :invitees, through: :invited_friendships

  def friends
    @friends ||= ( requested_friends + invited_friends).compact!
  end

  private

  def requested_friends
    @requested_friends ||= requested_friendships.map{ |v| v.status == 'accepted'? v.requesters : next }
  end

  def invited_friends
    @invited_friends ||= invited_friendships.map{ |v| v.status == 'accepted'? v.invitee : next }
  end
end
