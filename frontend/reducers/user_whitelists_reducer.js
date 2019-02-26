import merge from 'lodash/merge';

import {RECEIVE_USER_WHITELISTS, RECEIVE_USER_WHITELIST} from '../actions/user_whitelist_actions.js'

const defaultState = {};

const UserWhitelistsReducer = (state = defaultState, action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_USER_WHITELISTS:
      return action.userWhitelists;
    case RECEIVE_USER_WHITELIST:
      return merge({},state,{[action.userWhitelist.id]: action.userWhitelist});
    default:
      return state;
  }
};

export default UserWhitelistsReducer
