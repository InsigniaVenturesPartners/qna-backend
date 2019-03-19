import * as APIUtil from '../util/draft_api_util'

export const RECEIVE_DRAFT = 'RECEIVE_DRAFT';

export const receiveDraft = draft => ({
  type: RECEIVE_DRAFT,
  draft
});

export const saveDraft = (body, questionId) => dispatch => (
  APIUtil.saveDraft(body, questionId).then(
    draft=>(dispatch(receiveDraft(draft))
  ))
);

export const fetchQuestionDraft = questionId => dispatch => (
  APIUtil.fetchQuestionDraft(questionId).then(
    draft=>(dispatch(receiveDraft(draft))
  ))
);