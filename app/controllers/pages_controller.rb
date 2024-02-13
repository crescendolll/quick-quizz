class PagesController < ApplicationController
  def home
    @quiz_results = QuizResult.where(user_id: current_user.id)

    @quizzes = Quiz.all
    @recent_quizzes = @quizzes.last(3)

    @quiz_highscores = QuizResult.where("result >= ?", 1).order(created_at: :desc).limit(3)

    @quiz_feed = @recent_quizzes + @quiz_highscores
    @sorted_quiz_feed = @quiz_feed.sort_by(&:created_at).reverse
    @sorted_quiz_feed = @sorted_quiz_feed.take(6)
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
