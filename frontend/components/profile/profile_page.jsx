import React from 'react';
import { Link } from 'react-router-dom';

import AnswerItemContainer from '../answer_list/answer_item_container';
import TopicSearchContainer from '../topic_search/topic_search_container';
import FollowTopicButtonContainer from '../follow_topic_button/follow_topic_button_container'

class ProfilePage extends React.Component {
  constructor(props) {
    super(props)
  }

  componentWillMount() {
    this.props.requestTopics();
  }

  render () {
    const { user, topics } = this.props;
    console.log("topics 123");
    console.log(topics);

    const topicItems = topics.map( topic => (
      <li className="profile-question-list-item" key={ "topic-" + topic.id }>
        <Link to={`/topics/${topic.id}`}>{topic.name}</Link>
        <FollowTopicButtonContainer id={topic.id} followerIds={topic.follower_ids} followed={topic.followed}/>
      </li>
    ));

    return (
      <div id="topics-container">
        <ul className="topic-list">
          <div className="greeting">

            <div className="greeting-header">
              <img src={user.pro_pic_url} alt={`${user.name}'s picture`}  className="user-pro-pic" />
              <span>{user.name}</span>
            </div>

          </div>

           <li className="topic-list-item">
            <h2>Following Topics</h2>
            <ul className="profile-question-list">{topicItems}</ul>

          </li>


        </ul>
      </div>


    );

  }
}

export default ProfilePage;

