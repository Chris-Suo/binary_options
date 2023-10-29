class UsersController < ApplicationController
  before_action :check_admin!
  before_action :set_user, only: %i[show edit update quota add_quota destroy reset_password trials]
  before_action :set_level_options, only: %i[new edit]

  # GET /users or /users.json
  def index
    if current_user.admin?
      @users = User.all.order(level: :desc, created_by: :asc).page(params[:page]).per(50)
    elsif current_user.premium?
      @users = User.where(created_by: current_user.id).order(level: :desc, created_by: :asc).page(params[:page]).per(50)
    end
  end

  # GET /users/1 or /users/1.json
  def show
    if @user.created_by != current_user.id && current_user.premium?
      redirect_to(root_path)
    end
  end

  # GET /users/new
  def new
    @user = User.new
    @password = Time.zone.now.strftime("%m%d")
    @created_by = current_user.id
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create

    if User.exists?(username: user_params[:username])
      redirect_to(new_user_path, alert: "帳號已經存在。")
      return
    end

    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to(user_url(@user), notice: "成功新增員工。") }
        format.json { render(:show, status: :created, location: @user) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @user.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to(user_url(@user), notice: "成功修改員工。") }
        format.json { render(:show, status: :ok, location: @user) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @user.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url, notice: "成功刪除員工。") }
      format.json { head(:no_content) }
    end
  end

  def quota
    unless current_user.admin?
      redirect_to(root_path)
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def add_quota
    unless current_user.admin?
      redirect_to(root_path)
    end
    @user.quota += Integer(user_params[:add_quota], 10)

    respond_to do |format|
      if @user.save!
        format.html { redirect_to(user_url(@user), notice: "成功加減元件 #{user_params[:quota]}，總共元件是 #{@user.quota}。") }
        format.json { render(:show, status: :ok, location: @user) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @user.errors, status: :unprocessable_entity) }
      end
    end
  end

  def reset_password
    @user.update(password: Time.zone.now.strftime("%m%d"))
    respond_to do |format|
      format.html { redirect_to(users_url, notice: "已成功重設員工密碼為今天日期。") }
    end
  end

  def trials
    @trials = Trial.where(user_id: @user.id).order(created_at: :desc).page(params[:page]).per(50)
  end

  def toggle_active
    @user = User.find(params[:id])
    @user.active = !@user.active
    @user.save!
    redirect_to(users_url, notice: "成功切換帳號狀態。")
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def check_admin!
    redirect_to(root_path) if current_user.basic?
  end

  def set_level_options
    if current_user.admin?
      @options = [%w[組員 basic], %w[小組長 premium]]
    elsif current_user.premium?
      @options = [%w[組員 basic]]
    end
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :add_quota, :quota, :level, :active, :created_by, :password, :current_password, :password_confirmation)
  end
end
