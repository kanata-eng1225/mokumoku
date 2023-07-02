# frozen_string_literal: true

class Events::AttendancesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    event_attendance = current_user.attend(@event)
    (@event.attendees - [current_user] + [@event.user]).uniq.each do |user|
      NotificationFacade.attended_to_event(event_attendance, user)
    end
    redirect_back(fallback_location: root_path, success: '参加の申込をしました')
  end

  def destroy
    @event = Event.find(params[:event_id])
    current_user.cancel_attend(@event)
    redirect_back(fallback_location: root_path, success: '申込をキャンセルしました')
  end

  def show
    @event = Event.find(params[:event_id])  # 参加者の詳細ページを表示するイベントを取得します
    # binding.pry
    # @attendee = @event.attendees.find_by(id: params[:id])
    # @attendee = @event.attendees.find(params[:attendee_id])
    # @attendee = @event.attendees.find_by(id: 1)
    # @attendee = Attendee.find(params[:id])
    @attendee = User.find(params[:id])
    # @attendee = Event::Attendee.find(params[:id])
    # binding.pry
    # @attendee = @event.attendees.find_by(user_id: params[:user_id])
  end
end
