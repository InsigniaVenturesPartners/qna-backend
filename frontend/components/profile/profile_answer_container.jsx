import { connect } from 'react-redux';
import ProfileAnswer from './profile_answer';

// Actions
import { fetchProfileAnswers } from '../../actions/profile_actions';

import { allProfileAnswers } from '../../reducers/selectors';

const mapStateToProps = (state) => ({
  answers: allProfileAnswers(state),
  errors: state.errors
});

const mapDispatchToProps = dispatch => ({
	requestAnswers: () => dispatch(fetchProfileAnswers())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ProfileAnswer);