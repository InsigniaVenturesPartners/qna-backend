import { connect } from 'react-redux';
import ProfilePage from './profile_page';

// Actions
import { fetchTopics } from '../../actions/topic_actions';
import { fetchQuestion } from '../../actions/question_actions';

import { allTopics } from '../../reducers/selectors';

const mapStateToProps = (state, ownProps) => ({
  user: state.session.currentUser,
  id: ownProps.id,
  errors: state.errors
});

const mapDispatchToProps = dispatch => ({
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ProfilePage);