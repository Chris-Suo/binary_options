class HomeController < ApplicationController
  layout false, only: [:sync]

  def index
  end

  def sync
    if current_user.nil?
      puts "請先登入"
      redirect_to root_path, notice: '請先登入'
    end

    render json: { time: Time.zone.now.to_datetime, layout: false }
  end
end
