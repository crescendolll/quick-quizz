class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    redirect_to profile_path if user_signed_in?
  end

  def profile
    @user = current_user
    @created_quizzes = @user.quizzes
    @taken_quizzes = Quiz.joins(:quiz_results).where(quiz_results: { user_id: @user.id }).distinct
    @average_score = @user.quiz_results.average(:result).to_f
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path
  end

  def change_password
    @user = current_user
    if @user.update_with_password(user_params)
      bypass_sign_in(@user)
      redirect_to profile_path, notice: "Password changed successfully."
    else
      render 'change_password'
    end
  end


  def settings

  end

  def community

  end

  private

  def user_params
    if params[:user].present?
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    else
      params.permit(:current_password, :password, :password_confirmation)
    end
  end

end
