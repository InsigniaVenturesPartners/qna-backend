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
      created_at: @resource.created_at,
      answerIds:  @resource.answers.map{|answer| answer.id},
      num_answers: @resource.num_answers_str,
      commentIds: @resource.commentIds,
      followerIds: @resource.follower_ids,
      upvoterIds: @resource.upvoter_ids,
      match_score: @resource.match_score(keywords),
      topic: @resource.topics.first,
      tags: @resource.topics.map{|topic| [topic.id, topic.name]},
      is_draft: is_draft?,
      followed: is_followed?,
      downvoted: downvoted?,
      total_score: total_score?
    }
    hash.merge!(author: presenter_json(@resource.author))

    hash
  end

  def is_draft?
    return false unless @context[:current_user]
    @resource.is_drafted_by(@context[:current_user])
  end

  def is_followed?
    return false unless @context[:current_user]
    @context[:current_user].followed?(@resource)
  end

  def downvoted?
    return false unless @context[:current_user]
    @context[:current_user].downvoted?(@resource)
  end
  
  def total_score?
    return 0 unless @resource[:total]
    @resource[:total].to_i
  end
end







