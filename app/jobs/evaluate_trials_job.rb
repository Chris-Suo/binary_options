class EvaluateTrialsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    id = args[0]

    # 找出該注的正確與否
    trial = Trial.find_by_id(id)
    bets = [100, 100, 100, 100, trial.exam_option]
    returns = [30, 30, 30, 30, trial.exam_option]
    is_correct = trial.exam.answer_code == trial.answer

    # 準備要寫入的資料
    trial.correctness = is_correct
    trial.quota_before = trial.user.quota

    # 找出該注的返還對應index
    index = bets.find_index(trial.exam_option)
    puts "exam_option: #{trial.exam_option}"
    puts "index: #{index}"

    # 接著從陣列中找出返還數量
    if is_correct
      puts "returns[index]" + returns[index].to_s
      puts "trial.exam_option" + trial.exam_option.to_s

      change = returns[index] + trial.exam_option
      puts change
    else
      change = 0
    end

    # 計算返還後的點數
    trial.quota_after += trial.user.quota + change
    trial.quota_change = change

    # 同時更新兩個model
    ActiveRecord::Base.transaction do
      trial.save!
      trial.user.update!(quota: trial.quota_after)
    end

    # 通知使用者
    # ActionCable.server.broadcast("user_channel_#{trial.user.id}", { quota: trial.quota_after })
  end
end
