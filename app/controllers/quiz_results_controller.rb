class QuizResultsController < ApplicationController
  def new
    @quiz = Quiz.find(params[:quiz_id])
    @quiz_result = QuizResult.new
    @quiz_result.answers.build
  end

  def create
    @quiz = Quiz.find(params[:quiz_id])
    @quiz_result = QuizResult.new(quiz_result_params)

    @quiz_result.quiz = @quiz
    @quiz_result.user = current_user

    # this was the count for the number of correct answers (1 out of 5)
    # @quiz_result.result = (@quiz_result.answers.select { |answer| answer.choice.correct }.count)

    @quiz_result.result = 0
    @quiz_result.save!
    redirect_to quiz_result_path(@quiz_result)
  end

  def show
    @quiz_result = QuizResult.find(params[:id])
    @quiz_result.result = (@quiz_result.answers.select { |answer| answer.choice.correct }.count)*100/(@quiz_result.answers.count.to_f)
  end

  private

  def quiz_result_params
    params.require(:quiz_result).permit(answers_attributes: {})
  end
end
