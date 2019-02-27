import React from 'react';
import { Link } from 'react-router-dom';

import AnswerItemContainer from '../answer_list/answer_item_container';
import TopicSearchContainer from '../topic_search/topic_search_container';
import FollowTopicButtonContainer from '../follow_topic_button/follow_topic_button_container'

class ProfileTopic extends React.Component {
  constructor(props) {
    super(props)
  }

  componentWillMount() {
    this.props.requestTopics();
  }

  render () {
    const { topics } = this.props;

    const topicItems = topics.map( topic => (
      <li className="profile-question-list-item" key={ "topic-" + topic.id }>
        <div>
          <img src={topic.pic_url} />
        </div>
        <Link to={`/topics/${topic.id}`}>{topic.name}</Link>
        <FollowTopicButtonContainer id={topic.id} followerIds={topic.follower_ids} followed={topic.followed}/>
      </li>
    ));

    return (
       <li className="profile-topic-list-item">
        <h2>Following Topics</h2>
        <ul className="profile-question-list">{topicItems}</ul>
      </li>
    );

  }
}

export default ProfileTopic;

