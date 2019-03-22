import React from 'react';
import {Link} from 'react-router-dom';

import QuestionItemContainer from '../question/question_item_container'

class TopicListItem extends React.Component {
  constructor(props) {
    super(props)
  }

  render () {

    const { questions } = this.props;

    const questionItems = questions.sort(function(a, b) {
      const answerCount1 =  a.answer_ids.length;
      const answerCount2 =  b.answer_ids.length;

      if((answerCount1>0 && answerCount2>0) || (answerCount1===0 && answerCount2===0)) {
        return new Date(b.updated_at) - new Date(a.updated_at);
      } else if(answerCount1>answerCount2) {
        return -1;
      } else {
        return 1;
      }
    }).map(question => (
      <QuestionItemContainer
        key={ "question-" + question.id }
        id={question.id}
        />
      ));

    return (
      <li className="topic-list-item">
        {/*
          TODO
        <h2 className="topic-header"><Link to={`/topics/${topic.id}`} >{name}</Link></h2>
        */}
        <ul className="question-list">{questionItems}</ul>
        {/*
        <footer className="topic-list-item-footer">
          <Link to={`/topics/${topic.id}`} >View All</Link>
        </footer>
        */}
      </li>
    );

  }
}

export default TopicListItem;
