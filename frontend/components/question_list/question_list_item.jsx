import React from 'react';
import {Link} from 'react-router-dom';
import { connect } from 'react-redux';

import AnswerFormContainer from '../answer_form/answer_form_container';
import QuestionEditContainer from '../question/question_edit_form_container';

class QuestionListItem extends React.Component {
  constructor(props) {
    super(props)
  }

  render () {
    const { question } = this.props;

    if (Object.keys(question).length === 0) {
      return (
        <img src="https://image.ibb.co/iYo1yw/Screen_Shot_2017_09_28_at_6_43_28_PM.png" alt={`loading-image`}  className="loading-image" />
      );
    } else {
      const { id, body, time_posted_ago, topic, num_answers } = question;

      let questionHead;
      if(topic) {
        questionHead = [<h3>Question asked · {topic.name} · {time_posted_ago}</h3>];
      } else {
        questionHead = [<h3>Question asked · {time_posted_ago}</h3>];
      }

      return (
        <li className="question-list-item">
          {questionHead}
          <Link to={`/questions/${question.id}`} >{body}</Link>

          <h3>Last asked {time_posted_ago} · <Link to={`/questions/${question.id}`} >{num_answers}</Link></h3>

          <AnswerFormContainer questionId={id} body={body} authorId={question.author.id} isDraft={question.is_draft}/>
        </li>
      );
    }
  }
}

const mapStateToProps = (state) => ({
  user: state.session.currentUser
});

export default connect(
  mapStateToProps
)(QuestionListItem);

