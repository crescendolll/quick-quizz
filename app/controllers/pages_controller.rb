class PagesController < ApplicationController
  def home
    @my_quizzes = Quiz.includes(:quiz_results)
                          .where(user: current_user)
                          # .where.not(quiz_results: { id: nil }) # Ensures quizzes with at least one quiz_result
                          .order(created_at: :desc)
                          .map { |quiz| [quiz, quiz.quiz_results.maximum(:result)] }
                          .first(10)

    @quiz_feed = Quiz.all.where.not(user: current_user).last(3) + QuizResult.where.not(user: current_user).where("result >= ?", 1).order(created_at: :desc).limit(3)
    @sorted_quiz_feed = @quiz_feed.sort_by(&:created_at).reverse.take(6)
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
