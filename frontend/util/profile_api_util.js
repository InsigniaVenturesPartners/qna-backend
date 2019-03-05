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