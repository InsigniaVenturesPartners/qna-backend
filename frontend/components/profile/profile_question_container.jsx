import { connect } from 'react-redux';
import ProfileQuestion from './profile_question';

// Actions
import { fetchProfileQuestions } from '../../actions/question_actions';

import { allQuestions } from '../../reducers/selectors';

const mapStateToProps = (state) => ({
  questions: allQuestions(state),
  errors: state.errors
});

const mapDispatchToProps = dispatch => ({
	requestQuestions: () => dispatch(fetchProfileQuestions())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ProfileQuestion);