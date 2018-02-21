class ChartsController < ApplicationController
  def messages_per_hour
    render json: Message.group_by_hour_of_day(:created_at).count
  end

  def messages_per_user
    render json: Message.group(:user_id).count
  end

  def messages_per_user_per_hour
    render json: User.all.map { |u|
      {name: u.name, data: u.messages.group_by_hour_of_day(:created_at).count}
    }
  end
end
