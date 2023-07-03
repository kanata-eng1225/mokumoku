# frozen_string_literal: true

class Events::AttendancesController < ApplicationController
  before_action :set_event

  def create
    event_attendance = current_user.attend(@event)
    (@event.attendees - [current_user] + [@event.user]).uniq.each do |user|
      NotificationFacade.attended_to_event(event_attendance, user)
    end
    redirect_back(fallback_location: root_path, success: '参加の申込をしました')
  end

  def destroy
    current_user.cancel_attend(@event)
    redirect_back(fallback_location: root_path, success: '申込をキャンセルしました')
  end

  # 参加者の詳細ページを表示するイベントを取得
  def show
    @attendee = User.find(params[:id])
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
