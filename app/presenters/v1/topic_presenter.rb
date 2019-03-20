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
      pic_url: @resource.pic_url
    }

    hash
  end
end



# json.question_ids topic.questions.map{|question| question.id}

# json.follower_ids topic.follower_ids
# json.followed current_user.followed?(topic)

# json.match_score topic.match_score(keywords)