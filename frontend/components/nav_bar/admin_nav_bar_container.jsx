import { connect } from 'react-redux';
import AdminNavBar from './admin_nav_bar';

import { allTopics } from '../../reducers/selectors';

// Actions

const mapStateToProps = (state) => ({
  user: state.session.currentUser
});

const mapDispatchToProps = dispatch => ({

});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(AdminNavBar);
