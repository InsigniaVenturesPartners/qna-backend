import React from 'react';
import { Provider } from 'react-redux';
import { BrowserRouter, Route, Router, Redirect, Switch, Link, HashRouter} from 'react-router-dom';

import { createBrowserHistory } from 'history'

import SessionFormContainer from './session_form/session_form_container';
import TopicListContainer from './topic_list/topic_list_container';
import CreateQuestionFormContainer from './create_question_form/create_question_form_container';
import NavBarContainer from './nav_bar/nav_bar_container';
import FeedSidebarContainer from './feed_sidebar/feed_sidebar_container';
import TopicDetailContainer from './topic_detail/topic_detail_container';
import QuestionDetailContainer from './question_detail/question_detail_container';
import QuestionListContainer from './question_list/question_list_container';
import AnswerDetailContainer from './answer_detail/answer_detail_container';
import ProfilePageContainer from './profile/profile_page_container';
import ProfileTopicContainer from './profile/profile_topic_container';
import ProfileQuestionContainer from './profile/profile_question_container';
import ProfileAnswerContainer from './profile/profile_answer_container';
import UserWhitelistContainer from './user/user_whitelist_container';

const App = () => (

      <div>
        <Route path="/login" component={SessionFormContainer} />
        <Route path="/" component={NavBarContainer} />
        <div id="main-page">
          <div className="sidebar">
            <Route path="/" component={FeedSidebarContainer} />
          </div>

          <Switch>
            <div className="main-col">
              <Route exact path="/" component={CreateQuestionFormContainer} />
              <Route exact path="/" component={TopicListContainer} />
              <Route exact path="/topics/:topicId" component={TopicDetailContainer} />
              <Route exact path="/questions/:questionId" component={QuestionDetailContainer} />
              <Route exact path="/answers/:answerId" component={AnswerDetailContainer} />
              <Route exact path="/answer" component={QuestionListContainer} />
              <Route path="/profile" component={ProfilePageContainer} />
              <Route exact path="/profile" component={ProfileTopicContainer} />
              <Route exact path="/profile/topics" component={ProfileTopicContainer} />
              <Route exact path="/profile/questions" component={ProfileQuestionContainer} />
              <Route exact path="/profile/answers" component={ProfileAnswerContainer} />

              <Route path="/admin" component={UserWhitelistContainer} />
            </div>

          </Switch>

        </div>
      </div>

);

export default App;
