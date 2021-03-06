export const allTopics = ({ topics }) => Object.values(topics);

export const selectTopic = ({ topics }, id) => {
  const topic = topics[id] || {};
  return topic
};

export const selectDetailTopic = ({ detailTopic }, id) => {
  const topic = detailTopic[id] || {};
  return topic
};


export const allQuestions = ({ questions }) => {
  const returnQuestions = Object.values(questions) || [];
  return returnQuestions;
};

export const allProfileQuestions = ({ profile }) => {
  if(!profile.hasOwnProperty("questions")) return []
  const returnQuestions = Object.values(profile.questions) || [];
  return returnQuestions;
};

export const allProfileAnswers = ({ profile }) => {
  if(!profile.hasOwnProperty("answers")) return []
  const returnQuestions = Object.values(profile.answers) || [];
  return returnQuestions;
};

export const allTopQuestions = ({ questions }) => {
  const returnQuestions = Object.values(questions) || [];

  if(returnQuestions.length > 0) {
    return returnQuestions.sort(function(a, b) {
      const answerCount1 =  a.answer_ids.length;
      const answerCount2 =  b.answer_ids.length;
        return answerCount2 - answerCount1;
    });
  }

  return returnQuestions;
};

export const allAnswers = ({ answers }) => {
  const returnAnswers = Object.values(answers) || [];
  return returnAnswers;
};

export const allUserWhitelists = ({ userWhitelists }) => {
  const returnUserWhitelists = Object.values(userWhitelists) || [];
  return returnUserWhitelists;
};

export const selectQuestion = ({ questions }, id) => {
  const question = questions[id] || {};
  return question
};

export const selectAnswer = ({ answers }, id) => {
  const answer = answers[id] || {};
  return answer
};

export const selectComments = ({ comments }, commentIds) => {
  const allComments = Object.values(getState().comments)
  const selectComments = allComments.filter((comment)=>commentIds.includes(comment.id))

  return selectComments
};

//I filter here, since I might not have the query elsewhere
export const asSortedArray = ({ searchQuestions, filters }) => {
  return(
  Object.values(searchQuestions).sort((a,b)=>b.match_score - a.match_score)
  );
}

export const asSortedTopicArray = ({ searchTopics, filters }) => {
  return(
  Object.values(searchTopics).sort((a,b)=>b.match_score - a.match_score)
  );
}
