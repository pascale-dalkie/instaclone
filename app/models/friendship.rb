# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :requester, class_name: "User"
  belongs_to :invitee, class_name: "User"

  validates :status, presence: true

  STATUSES = %i[requested accepted declined].map(&:to_s).freeze

end
