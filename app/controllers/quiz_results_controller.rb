class QuizResultsController < ApplicationController
  def new
    @quiz = Quiz.find(params[:quiz_id])
    @quiz_result = QuizResult.new
    @quiz_result.answers.build
  end

  def create
    @quiz = Quiz.find(params[:quiz_id])
    @quiz_result = QuizResult.new(quiz_result_params)
    # @quiz_result.save!

    @quiz_result.quiz = @quiz
    @quiz_result.user = current_user

    @quiz_result.result = @quiz_result.answers.select { |answer| answer.choice.correct }.count
    @quiz_result.save!
    redirect_to quiz_result_path(@quiz_result)
  end

  def show
    @quiz_result = QuizResult.find(params[:id])
  end

  private

  def quiz_result_params
    params.require(:quiz_result).permit(answers_attributes: {})
  end
end
