class Api::V1::DraftsController < Api::V1::BaseController
  def create
    return render_error(422, {error: "Missing parameter question_id"}) unless params[:question_id]
    draft = Draft.find_by(question_id: params[:question_id], author_id: current_user)

    if(draft)
      draft.update(draft_params)
      return render_json(presenter_json(draft))
    else
      draft = Draft.new(draft_params)
      draft.author = current_user
      draft.question_id = params[:question_id]
      if draft.save
        return render_json(presenter_json(draft))
      else
        render_model_error(draft.errors.full_messages)
      end
    end
  end

  def me
    if params[:question_id]
      question = Question.find_by_id(params[:question_id])
      unless question
        return render_not_found(body = {error: "Question not found"})
      end
      draft = question.drafts.find_by(author_id: current_user)

      return render_json(presenter_json(draft)) if draft.present?
      return render_not_found
    else
      render_error(422, {error: "Missing parameter question_id"})
    end
  end

 private

  def draft_params
    params.require(:draft).permit(:body)
  end
end
