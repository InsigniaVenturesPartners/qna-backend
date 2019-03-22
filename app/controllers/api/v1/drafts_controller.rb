class Api::V1::DraftsController < Api::V1::BaseController
  def create
    @draft = Draft.find_by(question_id: params[:question_id], author_id: current_user)
    if(@draft)
      @draft.update(draft_params)
      render :show
      return
    else
      @draft = Draft.new(draft_params)
      @draft.author = current_user
      @draft.question_id = params[:question_id]
      if @draft.save
        render :show
        return
      else
        render json: @draft.errors.full_messages, status: 422
      end
    end
  end

  def me
    if params[:question_id]
      question = Question.find_by_id(params[:question_id])
      unless question
        render json: ["Question not found"], status: 404
        return
      end
      @draft = question.drafts.find_by(author_id: current_user)
      render :show

    else
      render json: "missing parameter question_id", status: 422
    end
  end

 private

  def draft_params
    params.require(:draft).permit(:body)
  end
end
