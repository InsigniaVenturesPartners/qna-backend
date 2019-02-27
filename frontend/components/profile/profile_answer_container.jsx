import { connect } from 'react-redux';
import ProfileAnswer from './profile_answer';

// Actions
import { fetchProfileAnswers } from '../../actions/question_actions';

import { allQuestions } from '../../reducers/selectors';

const mapStateToProps = (state) => ({
  questions: allQuestions(state),
  errors: state.errors
});

const mapDispatchToProps = dispatch => ({
	requestQuestions: () => dispatch(fetchProfileAnswers())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ProfileAnswer);