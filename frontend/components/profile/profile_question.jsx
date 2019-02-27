import React from 'react'
import { Link } from 'react-router-dom'

import AnswerItemContainer from '../answer_list/answer_item_container'
import TopicSearchContainer from '../topic_search/topic_search_container'
import FollowTopicButtonContainer from '../follow_topic_button/follow_topic_button_container'

import QuestionListItem from '../question_list/question_list_item'

import { Container, Header } from 'semantic-ui-react';

class ProfileQuestion extends React.Component {
  constructor(props) {
    super(props)
  }

  componentWillMount() {
    this.props.requestQuestions();
  }

  render () {
    const { questions } = this.props;

    const questionItems = questions.map( question => (
        <QuestionListItem key={ "question-" + question.id } question={question}/>
      )).reverse();

    const singleOrPluralText = questions.length <= 1 ? "Question" : "Questions"
    const headerText = `${questions.length} ${singleOrPluralText}`

    return (
        <div id="questions-container">
          <Header as='h1'>{headerText}</Header>

          <ul className="question-list">
            {questionItems}
          </ul>
        </div>
    );
  }
}

export default ProfileQuestion;

