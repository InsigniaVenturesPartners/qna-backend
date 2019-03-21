class V1::QuestionPresenter < BasePresenter
  def initialize(question, includes: [], context: {}, version: 1)
    super(question, includes, context: context, version: version)
  end

  def as_json
    keywords = @context[:keywords] || []

    hash = {
      id: @resource.id,
      body: @resource.body,
      time_posted_ago: @resource.time_posted_ago,
      updated_at: @resource.updated_at,
      answer_ids:  @resource.answers.map{|answer| answer.id},
      commend_ids: @resource.commentIds,
      follower_ids: @resource.follower_ids,
      upvoter_ids: @resource.upvoter_ids,
      match_score: @resource.match_score(keywords),
      topic: @resource.topics.first,
      tags: @resource.topics.map{|topic| [topic.id, topic.name]},
      followed: is_followed?,
      downvoted: downvoted?
    }
    hash.merge!(author: presenter_json(@resource.author))

    hash
  end

  def is_followed?
    return false unless @context[:current_user]
    @context[:current_user].followed?(@resource)
  end

  def downvoted?
    return false unless @context[:current_user]
    @context[:current_user].downvoted?(@resource)
  end
end







