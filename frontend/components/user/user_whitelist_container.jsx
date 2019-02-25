import { connect } from 'react-redux';
import { allUserWhitelists } from '../../reducers/selectors';
import UserWhitelist from './user_whitelist';

// Actions
import { fetchUserWhitelists, createUserWhitelist } from '../../actions/user_whitelist_actions';

const mapStateToProps = (state) => ({
  user_whitelists: allUserWhitelists(state),
  errors: state.errors
});

const mapDispatchToProps = dispatch => ({
  requestUserWhitelists: () => dispatch(fetchUserWhitelists()),
  createUserWhitelist: (email) => dispatch(createUserWhitelist(email))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(UserWhitelist);
