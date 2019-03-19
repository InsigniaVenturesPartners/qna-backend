import merge from 'lodash/merge';

import {RECEIVE_DRAFT} from '../actions/draft_actions.js'

const defaultState = {};

const DraftsReducer = (state = defaultState, action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_DRAFT:
      return merge({},state,{[action.draft.id]: action.draft});
    default:
      return state;
  }
};

export default DraftsReducer
