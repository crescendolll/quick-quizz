require "open-uri"
class QuizzesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def show
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user = User.first
    # @quiz.user = current_user
    if @quiz.save
      redirect_to test_path(quiz_id: @quiz.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def test
    @quiz = Quiz.find(params[:quiz_id])
    temp = Tempfile.new(["image"])
    temp.binmode
    temp.write(URI.open(@quiz.image.url).read)
    temp.rewind

    image = RTesseract.new(temp.path)

    @text_from_image = image.to_s

    # image.to_s
    # @text_from_image = image.text_for(@quiz.image.path).strip
  end

  def edit
  end

  private

  def quiz_params
    params.require(:quiz).permit(:image)
  end
end
