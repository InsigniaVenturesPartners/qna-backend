import React from 'react';
import {Link} from 'react-router-dom';

import QuestionItemContainer from '../question/question_item_container'

class TopicListItem extends React.Component {
  constructor(props) {
    super(props)
  }

  render () {
    const { topic } = this.props;
    // if(Object.keys(topic).length === 0) {
    //   return(<img src="https://image.ibb.co/iYo1yw/Screen_Shot_2017_09_28_at_6_43_28_PM.png" alt={`loading-image`}  className="loading-image" />);
    // } else {
      // const { name, description, num_followers, question_ids} = topic;
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

    // }

  }
}

export default TopicListItem;
