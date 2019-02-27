import React from 'react'
import { Link } from 'react-router-dom'

import AnswerItemContainer from '../answer_list/answer_item_container'
import TopicSearchContainer from '../topic_search/topic_search_container'
import FollowTopicButtonContainer from '../follow_topic_button/follow_topic_button_container'

import TopicListItem from '../topic_list/topic_list_item'

import { Container, Header } from 'semantic-ui-react';

class ProfileAnswer extends React.Component {
  constructor(props) {
    super(props)
  }

  componentWillMount() {
    // this.props.requestQuestions();
  }

  render () {
    const { questions } = this.props;

    // const questionItems = <TopicListItem key={ "question-1" } questions={answered_questions}/>

    // const questionItems2 = answered_questions.map(question => (
    //   <div>{question.body}</div>
    // ))

    const singleOrPluralText = questions.length <= 1 ? "Answer" : `Answers`
    const headerText = `${questions.length} ${singleOrPluralText}`

    return (
        <div id="questions-container">
          <Header as='h1'>{headerText}</Header>

          <ul className="question-list">

          </ul>
        </div>
    );

  }
}

export default ProfileAnswer;

