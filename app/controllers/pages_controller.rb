class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

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

  def settings
    @user = current_user
  end

  def community
  end
end
