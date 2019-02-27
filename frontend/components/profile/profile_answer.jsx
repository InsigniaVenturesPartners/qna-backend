import React from 'react'
import { Link } from 'react-router-dom'

import { Container, Header } from 'semantic-ui-react';

import AnswerItemContainer from '../answer_list/answer_item_container'
import TopicSearchContainer from '../topic_search/topic_search_container'
import FollowTopicButtonContainer from '../follow_topic_button/follow_topic_button_container'

import TopicListItem from '../topic_list/topic_list_item'
import QuestionItemContainer from '../question/question_item_container'


class ProfileAnswer extends React.Component {
  constructor(props) {
    super(props)
  }

  componentWillMount() {
    this.props.requestAnswers();
  }

  render () {
    const { answers } = this.props;

    // const questionItems = <TopicListItem key={ "question-1" } questions={answered_questions}/>

    const questionItems = answers.map(answer => (
      <QuestionItemContainer
        key={ "question-" + answer.question.id }
        id={answer.question.id}
        answerId={answer.id}
        />
    ))

    const singleOrPluralText = answers.length <= 1 ? "Answer" : `Answers`
    const headerText = `${answers.length} ${singleOrPluralText}`

    if(answers.length === 0) {
       return (
        <img src="https://image.ibb.co/iYo1yw/Screen_Shot_2017_09_28_at_6_43_28_PM.png" alt={`loading-image`}  className="loading-image" />
      );
    }

    return (
        <div id="answers-container">
          <Header as='h1'>{headerText}</Header>

          <ul className="question-list">
            {questionItems}
          </ul>
        </div>
    );

  }
}

export default ProfileAnswer;

