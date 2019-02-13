import React from 'react';
import { Link } from 'react-router-dom';

import AnswerItemContainer from '../answer_list/answer_item_container';
import TopicSearchContainer from '../topic_search/topic_search_container';
import FollowTopicButtonContainer from '../follow_topic_button/follow_topic_button_container'

class ProfilePage extends React.Component {
  constructor(props) {
    super(props)
  }

  render () {
    const { user, topics } = this.props;

    const topicItems = topics.map( topic => (
      <li key={ "topic-" + topic.id }>
        <Link to={`/topics/${topic.id}`}>{topic.name}</Link>
        <FollowTopicButtonContainer id={topic.id} followerIds={topic.follower_ids} followed={topic.followed}/>
      </li>
    ));

    return (
      <div>
        <div className="greeting">

          <div className="greeting-header">
            <img src={user.pro_pic_url} alt={`${user.name}'s picture`}  className="user-pro-pic" />
            <span>{user.name}</span>
          </div>

        </div>

        <div className="feed-sidebar-header">
          <div className= "feed-sidebar-fixed">
            <h2>Following Topics</h2>
          </div>
        </div>

        <ul className="sidebar-topic-list">
          {topicItems}
        </ul>
      </div>
    );

  }
}

export default ProfilePage;

