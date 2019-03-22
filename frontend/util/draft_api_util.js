export const fetchQuestionDraft = (question_id) => (
  $.ajax({
    method: 'GET',
    url: 'api/drafts/me',
    data: {
      question_id
    }
  })
);

export const saveDraft = (body, question_id) => (
  $.ajax({
    method: 'POST',
    url: 'api/drafts',
    data: {
      draft: {
        body
      },
      question_id
    }
  })
);