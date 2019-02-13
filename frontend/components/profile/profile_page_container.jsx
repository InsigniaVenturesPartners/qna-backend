import { connect } from 'react-redux';
import ProfilePage from './profile_page';

// Actions
import { fetchTopics } from '../../actions/topic_actions';
import { fetchQuestion } from '../../actions/question_actions';

import { allTopics } from '../../reducers/selectors';

const mapStateToProps = (state, ownProps) => ({
  user: state.session.currentUser,
  topics: allTopics(state),
  id: ownProps.id,
  errors: state.errors
});

const mapDispatchToProps = dispatch => ({
	requestTopics: () => dispatch(fetchTopics())
  // requestQuestion: (id) => dispatch(fetchQuestion(id)),
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ProfilePage);