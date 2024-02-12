require "open-uri"
class QuizzesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @my_quizzes = Quiz.includes(:quiz_results).where(user: current_user).order(created_at: :desc)
    @recently_created = request&.referer&.include?("new")
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
      redirect_to quizzes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
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
