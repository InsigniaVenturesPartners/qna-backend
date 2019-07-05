class V1::DraftPresenter < BasePresenter
  def initialize(draft, includes: [], context: {}, version: 1)
    super(draft, includes, context: context, version: version)
  end

  def as_json
    hash = {
      id: @resource.id,
      body: @resource.body,
      time_posted_ago: @resource.time_posted_ago,
    }
    hash.merge!(question: {
      id: @resource.question.id, 
      body: @resource.question.body,
      topics: @resource.question.topics,
      tags: @resource.question.topics.map{|topic| [topic.id, topic.name]}
    })
    hash.merge!(author: presenter_json(@resource.author))

    hash
  end
end