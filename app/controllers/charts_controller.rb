class ChartsController < ApplicationController
  def messages_per_hour
    render json: Message.group_by_hour_of_day(:created_at).count
  end
end
