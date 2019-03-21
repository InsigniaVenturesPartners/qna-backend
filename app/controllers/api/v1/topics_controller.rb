class Api::V1::TopicsController < Api::V1::BaseController
  def index
    if params[:topicQuery]
      keywords = []
      ##if it's empty, we want to fetch random topics to show
      if params[:topicQuery] == ""
        topics = Topic.order("RANDOM()").limit(7)
        reject_topics = current_user.followed_topics
        topics = topics.reject{|topic| reject_topics.include?(topic)}
      else
        keywords = params[:topicQuery].downcase.split(" ")
        topics = []

        keywords.each do |keyword|
          topics += Topic.where("LOWER(name) LIKE ? ", "%#{keyword.downcase}%")
        end

        topics = topics.uniq
      end
    else
      topics = Topic.order("name ASC")
    end
    topics = topics.paginate(page: params[:page], per_page: params[:per_page] || 10)
    render_json_paginate(topics, root: :topics, context: { current_user: current_user, keywords: keywords})
  end

  def show
    topic = Topic.find_by_id(params[:id])
    return render_not_found unless topic

    render_json(presenter_json(topic))
  end

  def follow
    topic = Topic.find(params[:topic_id])
    current_user.follow(topic)
    render_json(presenter_json(topic))
  end

  def unfollow
    topic = Topic.find(params[:topic_id])
    current_user.unfollow(topic)
    render_json(presenter_json(topic))
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :description)
  end
end
