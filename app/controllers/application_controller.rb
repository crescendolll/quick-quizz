class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def after_sign_in
    root_path
  end

  def after_sign_out_path
    new_user_session_path
  end
end
