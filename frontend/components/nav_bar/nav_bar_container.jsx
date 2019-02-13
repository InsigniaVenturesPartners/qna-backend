import { connect } from 'react-redux';
import NavBar from './nav_bar';

import { createQuestion } from '../../actions/question_actions';

import { allTopics } from '../../reducers/selectors';

// Actions

const mapStateToProps = (state, ownProps) => ({
  user: state.session.currentUser,
  topics: allTopics(state)
});

const mapDispatchToProps = dispatch => ({
  createQuestion: (body, topics) => dispatch(createQuestion(body, topics))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(NavBar);
