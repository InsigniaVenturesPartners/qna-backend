# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  name                   :string
#  pro_pic_url            :string
#  fb_id                  :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :rememberable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]
  # validates :username, :firstname, :lastname, :email, :pro_pic_url, :password_digest, :session_token, presence: true
  # validates :username, :email, :session_token, uniqueness: true
  # validates :password, length: {minimum: 6}, allow_nil: true

  #authored_questions
  has_many :authored_questions,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Question

  #topic_user join table
  has_many :topics_users,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :TopicsUser

  #topics subscribed to
  has_many :subscribed_topics,
    through: :topics_users,
    source: :topic

  #questions belonging to subscribed topics?
  has_many :feed_questions,
    through: :subscribed_topics,
    source: :questions

  has_many :answers,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Answer

  has_many :answered_questions,
    through: :answers,
    source: :question

  has_many :answered_topics,
    through: :answered_questions,
    source: :topics

  has_many :comments,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Comment

  has_many :partner_auths

  acts_as_voter
  #I don't think there's an easy way to cancle a vote which is scoped, so follows are scoped, with a positive vote meaning follow, and a negative or nil vote meaning unfollowed.  Up and downvotes are not scoped, allowing us to use the built-in unliked by
  def follow(entity)
    entity.vote_by :voter => self, :vote_scope => 'follow'
  end

  def unfollow(entity)
    entity.vote_by :voter => self, :vote => 'bad', :vote_scope => 'follow'
  end

  def upvote(entity)
    entity.vote_by :voter => self, :vote => 'like'
  end

  def downvote(entity)
    entity.vote_by :voter => self, :vote => 'bad'
  end

  def cancel_vote(entity)
    entity.unliked_by self
  end

  def followed_topics
    self.find_up_voted_items.select{|item| item.class == Topic}
  end

  def followed_questions
    #these are all the upvoted questions, but need to filter for questions which are followed, not just upvoted
    self.find_up_voted_items.select{|item| item.class == Question && item.follower_ids.include?(self.id)}.uniq
  end

  def upvoted_questions
    self.find_up_voted_items.select{|item| item.class == Question && item.up_voter_ids.include?(self.id)}.uniq
  end

  def upvoted_answers
    self.find_up_voted_items.select{|item| item.class == Answer && item.up_voter_ids.include?(self.id)}.uniq
  end

  def upvoted?(entity)
    self.voted_up_on? entity
  end

  def downvoted?(entity)
    self.voted_down_on? entity
  end

  def followed?(entity)
    self.voted_up_on? entity, vote_scope: 'follow'
  end

  def self.find_or_create_from_google_auth(auth)
    where(google_id: auth[:google_id]).first_or_initialize.tap do |user|
      user.update_attributes!(auth)
    end
  end

  def partner_auth_map
    res = {}
    self.partner_auths.each do |auth|
      res[auth.provider] = auth
    end

    return res
  end
  
  def has_offline_access
    return (self.partner_auth_map.key?("google") &&
        JSON.parse(self.partner_auth_map['google'].auth_json).key?("refresh_token"))
  end

end
