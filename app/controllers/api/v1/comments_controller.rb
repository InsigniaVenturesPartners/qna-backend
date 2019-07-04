class Api::V1::CommentsController < Api::V1::BaseController
  #returns based on params
  def index
    comments = Comment.none
    case params[:type]
    when "question"
      question = Question.find_by_id(params[:id])
      unless question
        return render_json({error: "Question not found"}, status = 404)
      end
      comments = question.comment_threads.includes(:user)

    when "answer"
      answer = Answer.find_by_id(params[:id])
      unless answer
        return render_json({error: "Topic not found"}, status = 404)
      end
      comments = answer.comment_threads.includes(:user)

    when "user"
      comments = current_user.comments
    end

    comments = comments.order(created_at: :desc).paginate(page: params[:page], per_page: params[:per_page] || 25)
    render_json_paginate(comments, root: :comments, context: { current_user: current_user })
  end

  def create
    commentableClass = Object.const_get(params[:commentableClass])
    commentable = commentableClass.find(params[:commentableId])
    author = current_user
    comment = Comment.build_from( commentable, author.id, params[:body] )
    comment.save!
    render_json(presenter_json(comment))
  end

  def show
    comment = Comment.find(params[:id])
    render_json(presenter_json(comment))
  end


  def vote
    comment = Comment.find_by_id(params[:comment_id])
    type = params[:type]
    case type
    when "upvote"
      current_user.upvote(comment)
    when "downvote"
      current_user.downvote(comment)
    when "cancel_vote"
      current_user.cancel_vote(comment)
    end
    render_json(presenter_json(comment))
  end

  def destroy

  end
end
