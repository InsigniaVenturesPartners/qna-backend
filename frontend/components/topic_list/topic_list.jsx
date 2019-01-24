import React from 'react';

import TopicListItem from './topic_list_item'

class TopicList extends React.Component {
  constructor(props) {
    super(props)
  }

  componentWillMount() {
    this.props.requestQuestions();
  }

  render() {
    // const {topics, voteOnAnswer, questions } = this.props;
    const topics = [];
    const voteOnAnswer = 0;
    const questions = this.props.questions;

    const topicItems = <TopicListItem key={ "question-1" } questions={questions}/>
      
    return(
      <div id="topics-container">
        <ul className="topic-list">
          {topicItems}
        </ul>
      </div>
    );
  }
}

export default TopicList;
