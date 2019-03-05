import { connect } from 'react-redux';
import ProfileQuestion from './profile_question';

// Actions
import { fetchProfileQuestions } from '../../actions/profile_actions';

import { allProfileQuestions } from '../../reducers/selectors';

const mapStateToProps = (state) => ({
  questions: allProfileQuestions(state),
  errors: state.errors
});

const mapDispatchToProps = dispatch => ({
	requestQuestions: () => dispatch(fetchProfileQuestions())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ProfileQuestion);