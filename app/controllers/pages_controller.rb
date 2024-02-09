class PagesController < ApplicationController

  def home
    @quiz_results = QuizResult.where(user_id: current_user.id)

    # TODO: this is just a mockup, replace with actual data when we have a structure
    @feed = User.where.not(id: 2).last(5)
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
