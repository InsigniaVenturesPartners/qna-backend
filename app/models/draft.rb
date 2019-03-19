class Draft < ApplicationRecord


  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  belongs_to :question,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :Question

  #code for time posted ago from github.com/katrinalui
  include ActionView::Helpers::DateHelper

  def time_posted_ago
    time_ago_in_words(updated_at) + " ago"
  end
end