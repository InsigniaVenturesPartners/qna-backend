import { connect } from 'react-redux';
import { allTopQuestions } from '../../reducers/selectors';
import QuestionList from './question_list';

// Actions
import { fetchTopQuestions } from '../../actions/question_actions';

const mapStateToProps = state => ({
  questions: allTopQuestions(state),
  errors: state.errors
});

const mapDispatchToProps = dispatch => ({
  requestTopQuestions: () => dispatch(fetchTopQuestions())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(QuestionList);
