class V1::TopicPresenter < BasePresenter
  def initialize(topic, includes: [], context: {}, version: 1)
    super(topic, includes, context: context, version: version)
  end

  def as_json
    hash = {
      id: @resource.id,
      name: @resource.name,
      description: @resource.description,
      num_followers: @resource.num_followers,
      pic_url: @resource.pic_url,
      follower_ids:  @resource.follower_ids,
      question_ids: @resource.questions.map{|question| question.id},
      match_score: @resource.match_score(@context[:keywords]),
      followed: is_followed?
    }

    hash
  end

  def is_followed?
    return false unless @context[:current_user]
    @context[:current_user].followed?(@resource)
  end
end
