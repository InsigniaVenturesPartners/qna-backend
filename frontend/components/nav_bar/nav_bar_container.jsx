import React from 'react';
import { withRouter } from 'react-router-dom';

import AdminNavBarContainer from './admin_nav_bar_container';
import UserNavBarContainer from './user_nav_bar_container';

class NavBarContainer extends React.Component {
  constructor() {
    super()
  }

  render() {
    const {user} = this.props

    const pathname = this.props.location.pathname;

    if(pathname.startsWith("/admin")) {
      return (
        <AdminNavBarContainer/>
      );
    } else {
      return (
        <UserNavBarContainer />
      );
    }
  }
}

export default withRouter(NavBarContainer);
