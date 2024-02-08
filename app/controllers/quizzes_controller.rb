require "open-uri"
class QuizzesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @user = current_user
    @my_quizzes = Quiz.where(user: @user).order(created_at: :desc)
    @recently_created = request&.referer&.include?("new")
  end

  def show
    @quiz = Quiz.find(params[:id])
    # @user_input = params[:text]
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user = current_user
    if @quiz.save
      if @quiz.image.attached?
        temp = Tempfile.new(["image"])
        temp.binmode
        temp.write(URI.open(@quiz.image.url).read)
        temp.rewind
        image = RTesseract.new(temp.path)
        @quiz.text = image.to_s
      end
      # redirect_to quiz_path(@quiz, text: @quiz.text)
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
