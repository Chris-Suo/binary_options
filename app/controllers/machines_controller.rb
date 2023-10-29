class MachinesController < ApplicationController
  before_action :check_admin!, only: %i[index show_exams switch]
  before_action :set_machine, only: %i[show show_exams switch sync]
  before_action :set_exam_options, only: %i[show]

  def show
    @machine = Machine.find_by_slug(params[:slug])
    if current_user.active == false
      flash[:alert] = "操作不當，目前無法使用"
    end

    if @machine.nil?
      redirect_to root_path, notice: '目前沒有這台機器'
    end
  end

  def update
    @machine = Machine.find_by(id: params[:id])
    if @machine.update(machine_params)

      redirect_to machines_path, notice: "成功修改機器。"
    else
      redirect_to machines_path, alert: "修改機器失敗。", status: :unprocessable_entity
    end
  end

  def index
    @all_machines = Machine.all.order(:id)
  end

  def show_exams
    if params[:page].nil?
      params[:page] = 0
    end

    @answers = @machine.exams.page(params[:page]).per(60)
                      #  .where("batch_at >= ?", Time.zone.today.beginning_of_day)
                      #  .where("batch_at <= ?", Time.zone.today.end_of_day)
                       .order(batch_at: :asc)

    if @machine.nil?
      redirect_to machines_path, notice: '目前沒有這台機器'
    end
  end

  def switch
    @machine.update(on_off: !@machine.on_off)
    redirect_to show_exams_path(slug: @machine.slug), notice: '機器狀態已經切換'
  end

  def sync
    if @machine.on_off == false
      render json: { time: nil, layout: false }
    end

    if current_user.nil?
      redirect_to root_path, notice: '請先登入'
    end

    render json: { time: Time.zone.now.to_datetime, layout: false }
  end

  def create_trial
    flash[:alert] = "操作不當"
    machine = Machine.find_by_id(trial_params[:machine_id])
    answer = trial_params[:answer].to_i
    time = DateTime.parse(trial_params[:time]).localtime.beginning_of_minute
    exam = machine.exams.find_by(batch_at: time)

    if time.to_i > Time.now.to_i + 2000 || time.to_i < Time.now.to_i - 2000
      redirect_to machine_path(machine.slug), alert: '檢測時間驗證不正確'
      return
    end

    # if machine.on_off == true
    
    # end

    if exam.nil? || machine.on_off == false
      redirect_to machine_path(machine.slug), alert: '目前沒有安排檢測'
      return
    end

    trial = Trial.new(batch_at_code: time.to_i)
    trial.machine = machine
    trial.user = current_user
    trial.exam = exam
    trial.answer = answer
    trial.exam_option = trial_params[:exam_option]

    if current_user.trials.exists?(batch_at_code: time.to_i)

      trial.duplicated = true
    end

    ActiveRecord::Base.transaction do
      trial.save!
      trial.user.update!(quota: trial.user.quota - trial_params[:exam_option].to_i)
    end

    wait_section = (DateTime.parse(trial_params[:time]).localtime.end_of_minute.to_i - Time.now.to_i) + 1

    puts wait_section

    EvaluateTrialsJob.set(wait: wait_section.seconds).perform_later(trial.id)
    # EvaluateTrialsJob.perform_later(trial.id)

    redirect_to machine_path(machine.slug), notice: '檢測操作完成'
  end

  private

  def trial_params
    params.require(:trial).permit(:slug, :user_id, :machine_id, :answer, :time, :exam_option)
  end

  def machine_params
    params.require(:machine).permit(:custom_option)
  end

  def set_machine
    @machine = Machine.find_by_slug(params[:slug])
  end

  def set_exam_options
    exam_options = [100, 100, 100, 100, @machine.custom_option]
    @options = @machine.exam_options.zip(exam_options)
  end

  def check_admin!
    redirect_to(root_path) unless current_user.admin?
  end
end
