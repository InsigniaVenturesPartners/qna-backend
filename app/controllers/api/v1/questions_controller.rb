class Api::V1::QuestionsController < Api::V1::BaseController
  def index
    questions = Question.all.includes(:author)
    keywords = []
    if params[:query]
      keywords = params[:query].downcase.split(" ")
      keywords.each do |keyword|
        questions = questions.where("LOWER(body) ~* ?", "(^#{keyword}.*|.* #{keyword}.*)")
      end
    else
      questions = questions.limit(20)
    end

    questions = questions.paginate(page: params[:page], per_page: params[:per_page] || 25)
    render_json_paginate(questions, root: :questions, context: { current_user: current_user, keywords: keywords })
  end

  def top
    questions = Question.all.includes(:author)
    questions = questions.includes(:answers).where.not(answers: {author_id: current_user.id})

    questions = questions.paginate(page: params[:page], per_page: params[:per_page] || 25)
    render_json_paginate(questions, root: :questions, context: { current_user: current_user })
  end

  def profile
    questions = Question.where("author_id = ?", current_user.id)

    questions = questions.paginate(page: params[:page], per_page: params[:per_page] || 25)
    render_json_paginate(questions, root: :questions, context: { current_user: current_user })
  end

  def show
    question = Question.find_by_id(params[:id])
    return render_not_found unless question

    render_json(presenter_json(question))
  end

  def create
    question = Question.create do |que|
      que.body = question_params[:body]
      que.author = current_user
    end

    if(question_params[:topics])
      question_params[:topics].each do |topic|
        t = Topic.find_by(name: topic)
        question.topics += [t] if t.present?
      end
    end

    render_created(presenter_json(question))
  end



  def update
    question = Question.find_by_id(params[:id])
    return render_not_found unless question

    question.update(question_params)

    render_json(presenter_json(question))
  end

  def vote
    question = Question.find_by_id(params[:question_id])
    type = params[:type]
    case type
    when "upvote"
      current_user.upvote(question)
    when "downvote"
      current_user.downvote(question)
    when "cancel_vote"
      current_user.cancel_vote(question)
    end
    render_json(presenter_json(question))
  end

  def follow
    question = Question.find_by_id(params[:question_id])
    current_user.follow(question)
    render_json(presenter_json(question))
  end

  def unfollow
    question = Question.find_by_id(params[:question_id])
    current_user.unfollow( uestion)
    render_json(presenter_json(question))
  end

  private

  def question_params
    params.require(:question).permit(:body, :topics => [])
  end
end
