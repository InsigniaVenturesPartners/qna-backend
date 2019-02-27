//Doesn't take a user argument, since in the controller it uses the current_user as the user
export const fetchQuestions = data => (
  $.ajax({
    method: 'GET',
    url: 'api/questions',
    data
  })
);

export const fetchTopQuestions = () => (
  $.ajax({
    method: 'GET',
    url: 'api/top/questions'
  })
);


export const fetchProfileQuestions = () => (
  $.ajax({
    method: 'GET',
    url: 'api/profile/questions'
  })
);

export const fetchProfileAnswers = () => (
  $.ajax({
    method: 'GET',
    url: 'api/profile/answers'
  })
);

export const fetchQuestion = (id) => (
  $.ajax({
    method: 'GET',
    url: `api/questions/${id}`,
  })
);

export const createQuestion = (body, topics) => (
  $.ajax({
    method: 'POST',
    url: `api/questions`,
    data: {
      question: {
        topics: topics,
        body
      }
    }
  })
);

export const editQuestion = (body, question_id) => (
  $.ajax({
    method: 'PATCH',
    url: `api/questions/${question_id}`,
    data: {
      question: {
        body
      }
    }
  })
);

export const voteOnQuestion = (id, type) => (
  $.ajax({
    method: 'POST',
    url: `api/questions/vote`,
    data: {
      question_id: id,
      type
    }
  })
);

export const followQuestion = (id) => (
  $.ajax({
    method: 'POST',
    url: `api/questions/follow`,
    data: {
      question_id: id,
    }
  })
);

export const unfollowQuestion = (id) => (
  $.ajax({
    method: 'POST',
    url: `api/questions/unfollow`,
    data: {
      question_id: id,
    }
  })
);
