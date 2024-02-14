class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def after_sign_in
    root_path
  end

  def after_sign_out_path
    new_user_session_path
  end
end
