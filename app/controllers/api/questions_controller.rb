class Api::QuestionsController < ApplicationController
  #modify index to only return current_user.questions or something like that
  #do a before action ensure login

  #shows all of the questions for a user
  def index
    questions = Question.all.includes(:author)
    if params[:query]
      @keywords = params[:query].downcase.split(" ")
      que = []
      @keywords.each do |keyword|
        que += questions.where("LOWER(body) ~* ?", "(^#{keyword}.*|.* #{keyword}.*)")
      end
      @questions = que.uniq
    else
      @questions = questions.take(20)
    end
    render :index
  end

  def top
    questions = Question.all.includes(:author)
    @questions = questions.reject {|que| que.answers.where("author_id = ?", current_user.id).any?}
    @current_user = current_user
    render :index
  end

  def profile
    @questions = Question.where("author_id = ?", current_user.id)

    render :index
  end

  def show
    @question = Question.find(params[:id])
    unless @question
      @question = {}
    end
    render :show
  end

  def create
    @question = Question.create do |que|
      que.body = question_params[:body]
      que.author = current_user
    end

    if(question_params[:topics])
      question_params[:topics].each do |topic|
        t = Topic.find_by(name: topic)
        @question.topics += [t] if t.present?
      end
    end

    render :show
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params)

    render :show
  end

  def vote
    @question = Question.find_by_id(params[:question_id])
    type = params[:type]
    case type
    when "upvote"
      current_user.upvote(@question)
    when "downvote"
      current_user.downvote(@question)
    when "cancel_vote"
      current_user.cancel_vote(@question)
    end
    render :show
  end

  def follow
    @question = Question.find_by_id(params[:question_id])
    current_user.follow(@question)
    render :show
  end

  def unfollow
    @question = Question.find_by_id(params[:question_id])
    current_user.unfollow(@question)
    render :show
  end

  private

  def question_params
    params.require(:question).permit(:body, :topics => [])
  end

end
