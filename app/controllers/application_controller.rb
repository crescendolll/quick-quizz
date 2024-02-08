class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def after_sign_in
    profile_path
  end
end
