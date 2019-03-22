import * as APIUtil from '../util/profile_api_util'

export const RECEIVE_PROFILE_QUESTIONS = 'RECEIVE_PROFILE_QUESTIONS';
export const RECEIVE_PROFILE_ANSWERS = 'RECEIVE_PROFILE_ANSWERS';


export const receiveProfileQuestions = questions => ({
  type: RECEIVE_PROFILE_QUESTIONS,
  questions
});

export const receiveProfileAnswers = answers => ({
  type: RECEIVE_PROFILE_ANSWERS,
  answers
});

export const fetchProfileQuestions = () => dispatch => (
  APIUtil.fetchProfileQuestions().then(
    questions=>(dispatch(receiveProfileQuestions(questions))
  ))
);

export const fetchProfileAnswers = () => dispatch => (
  APIUtil.fetchProfileAnswers().then(
    answers=>(dispatch(receiveProfileAnswers(answers))
  ))
);