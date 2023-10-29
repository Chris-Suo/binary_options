class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :load_machines
  before_action :set_csrf_cookie

  def load_machines
    @on_off_machines = Machine.where(on_off: true).order(:id)
  end

  def after_sign_in_path_for(resource)
    case resource.level
    when "basic"
      root_path
    when "premium"
      root_path
    when "admin"
      root_path
    else
      super
    end
  end

  private

  def set_csrf_cookie
    cookies["CSRF-TOKEN"] = form_authenticity_token
  end
end
