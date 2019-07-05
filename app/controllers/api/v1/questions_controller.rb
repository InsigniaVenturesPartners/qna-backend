class Api::V1::QuestionsController < Api::V1::BaseController
  def index
    questions = Question.includes(:author, :topics, :answers, :questions_topics, :drafts)
    keywords = []

    if params[:answered]
      orderAnswer = "SELECT question_id, COALESCE((select SUM(vote_weight) from votes where votable_type = 'Answer' and votable_id = answers.id group by votable_id), 0) as total FROM answers ORDER BY total desc"
      questions = questions.select("*, sub.total as total")
      .joins("INNER JOIN (#{orderAnswer}) sub ON questions.id = sub.question_id")
      .order("sub.total desc")
    else
      questions = questions.order(created_at: :desc)
    end

    if params[:query]
      keywords = params[:query].downcase.split(" ")
      keywords.each do |keyword|
        questions = questions.where("LOWER(body) ~* ?", "(^#{keyword}.*|.* #{keyword}.*)")
      end
    # else
    #   questions = questions.limit(20)
    end
    if params[:topic_id]
      questions = questions.where(id: QuestionsTopic.where(topic_id: params[:topic_id]))
    end

    questions = questions.paginate(page: params[:page], per_page: params[:per_page] || 25)
    render_json_paginate(questions, root: :questions, context: { current_user: current_user, keywords: keywords })
  end

  def top
    exclude = Answer.where(answers: {author_id: current_user.id})
    questions = Question.all.includes(:author).where.not(id: exclude)

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
    findQuestion = Question.where(body: question_params[:body]).first
    return render_error(:unprocessable_entity, {error: "DUPLICATED"}) if findQuestion
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

    if(question_params[:topic_ids])
      question_params[:topic_ids].each do |topic|
        t = Topic.find_by(id: topic)
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
    current_user.unfollow( question)
    render_json(presenter_json(question))
  end

  private

  def question_params
    params.require(:question).permit(:body, :topics => [], :topic_ids => [])
  end
end
