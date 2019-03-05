import { connect } from 'react-redux';
import ProfileTopic from './profile_topic';

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
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ProfileTopic);