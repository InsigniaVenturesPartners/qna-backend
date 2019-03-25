class V1::AnswerPresenter < BasePresenter
  def initialize(answer, includes: [], context: {}, version: 1)
    super(answer, includes, context: context, version: version)
  end

  def as_json
    hash = {
      id: @resource.id,
      body: @resource.body,
      time_posted_ago: @resource.time_posted_ago,
      upvoter_ids: @resource.upvoter_ids,
      comment_ids:  @resource.comment_ids,
      upvoted: upvoted?,
      downvoted: downvoted?
    }
    hash.merge!(question: {id: @resource.question.id, body: @resource.question.body})
    hash.merge!(author: presenter_json(@resource.author))

    hash
  end

  def upvoted?
    return false unless @context[:current_user]
    @context[:current_user].upvoted?(@resource)
  end

  def downvoted?
    return false unless @context[:current_user]
    @context[:current_user].downvoted?(@resource)
  end
end
