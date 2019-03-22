import { connect } from 'react-redux';
import { selectAnswer } from '../../reducers/selectors';
import AnswerItem from './answer_item';


// Actions
import { fetchAnswer, editAnswer, voteOnAnswer } from '../../actions/answer_actions';

const mapStateToProps = (state, ownProps) => ({
  answer: selectAnswer(state, ownProps.id),
  id: ownProps.id,
  errors: state.errors,
  comments: state.comments,
  user: state.session.currentUser
});

const mapDispatchToProps = dispatch => ({
  requestAnswer: (id) => dispatch(fetchAnswer(id)),
  editAnswer: (body, answerId) => dispatch(editAnswer(body, answerId)),
  voteOnAnswer: (id, type) => dispatch(voteOnAnswer(id, type))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(AnswerItem);
