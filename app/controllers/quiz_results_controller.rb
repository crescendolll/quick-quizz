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
    # TODO refactor: remove presence true & add result calc in quiz_res model after create
    @quiz_result.result = 0
    @quiz_result.save
    @quiz_result.answers.each { |answer| answer.save }
    if @quiz_result.answers.count > 0
      @quiz_result.result = (@quiz_result.answers.select { |answer| answer.choice.correct }.count) / (@quiz_result.answers.count.to_f)
    end
    @quiz_result.save
    redirect_to quiz_result_path(@quiz_result)
  end

  def show
    @quiz_result = QuizResult.find(params[:id])
    @show_result = @quiz_result.result * 100
    @wrong_answers = @quiz_result.answers.select { |answer| !answer.choice.correct }
    @answers = @quiz_result.answers
    @recommendations = Recommendation.all
    @quiz_recommendations = @recommendations.select { |recommendation| @wrong_answers.include?(recommendation.answer) }
  end

  private

  def quiz_result_params
    params.require(:quiz_result).permit(answers_attributes: {})
  end
end
