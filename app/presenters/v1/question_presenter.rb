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
      match_score: @resource.match_score(keywords),
    }
    hash.merge!(author: presenter_json(@resource.author))

    hash
  end

  def is_followed?
    return false unless @context[:current_user]
    @context[:current_user].followed?(@resource)
  end
end



# json.author do
#   json.partial! 'api/users/user', user: question.author
# end

# json.time_posted_ago question.time_posted_ago
# json.updated_at question.updated_at

# json.answer_ids question.answers.map{|answer| answer.id}

# json.topic question.topics.first
# json.tags question.topics.map{|topic| [topic.id, topic.name]}

# json.num_answers question.num_answers_str
# keywords ||= []

# json.match_score question.match_score(keywords)

# json.commentIds question.commentIds


# json.follower_ids question.follower_ids
# json.upvoter_ids question.upvoter_ids

# json.followed current_user.followed?(question)
# json.downvoted current_user.downvoted?(question)
