import { connect } from 'react-redux';
import { allTopics } from '../../reducers/selectors';
import QuestionForm from './create_question_form';

// Actions
import { createQuestion } from '../../actions/question_actions';

const mapStateToProps = (state) => {
  return {
  	topics: allTopics(state),
    user: state.session.currentUser
  }
};

const mapDispatchToProps = dispatch => ({
  createQuestion: (body, topics) => dispatch(createQuestion(body, topics))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(QuestionForm);
