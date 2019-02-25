import * as APIUtil from '../util/user_whitelist_api_util'

export const RECEIVE_USER_WHITELISTS = 'RECEIVE_USER_WHITELISTS';
export const RECEIVE_USER_WHITELIST = 'RECEIVE_USER_WHITELIST';

export const receiveUserWhitelists = userWhitelists => ({
  type: RECEIVE_USER_WHITELISTS,
  userWhitelists
});

export const receiveUserWhitelist = userWhitelist => ({
  type: RECEIVE_USER_WHITELIST,
  userWhitelist
});

export const fetchUserWhitelists = () => dispatch => (
  APIUtil.fetchUserWhitelists().then(
    userWhitelists=>(dispatch(receiveUserWhitelists(userWhitelists))
  ))
);

export const createUserWhitelist = (email) => dispatch => (
  APIUtil.createUserWhitelist(email).then(
    userWhitelist=>(dispatch(receiveUserWhitelist(userWhitelist))
  ))
);


