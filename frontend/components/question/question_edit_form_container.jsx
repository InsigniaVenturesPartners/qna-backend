import { connect } from 'react-redux';
import { allTopics } from '../../reducers/selectors';
import QuestionEditForm from './question_edit_form';

// Actions
import { editQuestion } from '../../actions/question_actions';

const mapStateToProps = (state) => {
  return {
    user: state.session.currentUser
  }
};

const mapDispatchToProps = dispatch => ({
  editQuestion: (body, questionId) => dispatch(editQuestion(body, questionId))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(QuestionEditForm);
