class V1::CommentPresenter < BasePresenter
  def initialize(comment, includes: [], context: {}, version: 1)
    super(comment, includes, context: context, version: version)
  end

  def as_json
    hash = {
      id: @resource.id,
      body: @resource.body,
      time_posted_ago: @resource.time_posted_ago,
      upvoter_ids: @resource.upvoter_ids,
      upvoted: upvoted?,
      downvoted: downvoted?
    }
    hash.merge!(author: presenter_json(@resource.user))

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


