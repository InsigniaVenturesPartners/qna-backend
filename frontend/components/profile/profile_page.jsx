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
    const { user } = this.props;

    return (
      <div id="topics-container">
        <ul className="topic-list">
          <div className="profile-greeting">
            <div className="profile-header">
              <img src={user.pro_pic_url} alt={`${user.name}'s picture`}  className="user-pro-pic" />
              <h2>{user.name}</h2>
            </div>
          </div>
        </ul>
      </div>
    );

  }
}

export default ProfilePage;

