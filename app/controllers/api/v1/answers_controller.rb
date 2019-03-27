class Api::V1::AnswersController < Api::V1::BaseController
  def index
    if params[:question_id]
      question = Question.find_by_id(params[:question_id])
      unless question
        return render_not_found(body = {error: "Question not found"})
      end
      answers = question.answers.includes(:author)
    elsif params[:topic_id]
      topic = Topic.find_by_id(params[:topic_id])
      unless topic
        return render_not_found(body = {error: "Topic not found"})
      end
      answers = topic.answers.includes(:author)
    else
      answers = current_user.answers
    end

    answers = answers.paginate(page: params[:page], per_page: params[:per_page] || 25)
    render_json_paginate(answers, root: :answers, context: { current_user: current_user })
  end

  def profile
    answers = Answer.where("author_id = ?", current_user.id)

    answers = answers.paginate(page: params[:page], per_page: params[:per_page] || 25)
    render_json_paginate(answers, root: :answers, context: { current_user: current_user })
  end

  def show
    answer = Answer.find(params[:id])
    render_json(presenter_json(answer))
  end

  def create
    answer = Answer.new(answer_params)
    answer.author = current_user
    answer.question_id = params[:question_id]
    if answer.save
      return render_json(presenter_json(answer))
    else
      render_model_error(answer.errors.full_messages)
    end
  end

  def update
    answer = Answer.find(params[:id])
    answer.update(answer_params)

    render_json(presenter_json(answer))
  end

  def vote
    answer = Answer.find_by_id(params[:answer_id])
    type = params[:type]
    case type
    when "upvote"
      current_user.upvote(answer)
    when "downvote"
      current_user.downvote(answer)
    when "cancel_vote"
      current_user.cancel_vote(answer)
    end
    render_json(presenter_json(answer, context: { current_user: current_user }))
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
