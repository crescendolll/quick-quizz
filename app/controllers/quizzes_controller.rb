require "open-uri"
class QuizzesController < ApplicationController
  # skip_before_action :authenticate_user!

  def index
    # quizzes that I own with highest resut.
    my_quizzes = Quiz.includes(:quiz_results)
    .where(user: current_user)
    .order(created_at: :desc)
    .map { |quiz| [quiz, quiz.quiz_results.maximum(:result)] }

    # quizzes that i dont own but have taken
    taken_quizzes = Quiz.joins(:quiz_results)
    .where.not(user_id: current_user.id) # Exclude quizzes owned by the current user
    .where(quiz_results: { user_id: current_user.id })
    .distinct
    .map { |quiz| [quiz, quiz.quiz_results.maximum(:result)] }

    @sorted = (my_quizzes + taken_quizzes).sort_by { |quiz, _| quiz.created_at }.reverse
    @recently_created = request&.referer&.include?("new") && params[:origin] == "create"
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user = current_user
    if @quiz.save
      redirect_to quizzes_path(origin: "create")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy
    redirect_to quizzes_path, status: :see_other
  end

  private

  def quiz_params
    params.require(:quiz).permit(:image, :text)
  end

end
