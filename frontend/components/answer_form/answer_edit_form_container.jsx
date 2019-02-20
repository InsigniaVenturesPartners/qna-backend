import { connect } from 'react-redux';
import AnswerEditForm from './answer_edit_form';

import { withRouter } from 'react-router-dom';

// Actions
import { editAnswer } from '../../actions/answer_actions';

const mapStateToProps = (state, ownProps) => ({
  answerId: ownProps.answerId,
  body: ownProps.body,
  current_user: state.session.currentUser

});

const mapDispatchToProps = dispatch => ({
  editAnswer: (body, answerId) => dispatch(editAnswer(body, answerId))
});

export default withRouter(connect(
  mapStateToProps,
  mapDispatchToProps
)(AnswerEditForm));
