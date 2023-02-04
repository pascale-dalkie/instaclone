# frozen_string_literal: true

class FriendshipsController < ApplicationController

  def create
    invitee = User.find(params[:invitee_id])
    Friendship.create(requester: current_user, invitee: invitee)
  end

  def change_status
    @friendship = Friendship.find(params[:id])
    if params[:status].present? && Friendship::STATUSES.include?(params[:status].to_sym)
      @friendship.update(status: params[:status])
    end
  end
end
