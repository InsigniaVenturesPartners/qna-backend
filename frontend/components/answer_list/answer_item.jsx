import React from 'react';
import ReactHtmlParser from 'react-html-parser';

import AnswerVoteButtonContainer from '../answer_vote_button/answer_vote_button_container';

import CommentListContainer from '../comment_list/comment_list_container';
import CommentFormContainer from '../comment_form/comment_form_container';
import AnswerEditFormContainer from '../answer_form/answer_edit_form_container';

import TruncateMarkup from 'react-truncate-markup';

class AnswerItem extends React.Component {
  constructor(props) {
    super(props)
    this.state = { commentOpen: false, editOpen: false, needTruncation: false, isExpanded: false};
    this.comments = this.comments.bind(this);

    this.openEditForm = this.openEditForm.bind(this);
    this.closeEditForm = this.closeEditForm.bind(this);
    this.handleAnswerExpand = this.handleAnswerExpand.bind(this);
  }

  componentWillMount() {
    this.props.requestAnswer(this.props.id);
  }

  componentWillReceiveProps(nextProps) {
    if(this.props.comments != nextProps.comments) {
      this.props.requestAnswer(this.props.id);
    }
  }

  openEditForm(body, answerId) {
    this.setState({editOpen: true});
  }

  closeEditForm() {
    this.setState({editOpen: false});
  }

  comments(id, commentIds) {
    if(this.state.commentOpen) {
      return (<div className="comments">
        <CommentFormContainer commentableId={id} commentableClass="Answer"/>
      <CommentListContainer commentIds={commentIds} commentableId={id} type={"answer"} />
      </div>);
    }
    return null;
  }

  handleAnswerExpand() {
    this.setState({ isExpanded: true })
  }

  render () {
    const { answer, voteOnAnswer, user } = this.props;
    if (Object.keys(answer).length === 0) {
      return(<img src="https://image.ibb.co/iYo1yw/Screen_Shot_2017_09_28_at_6_43_28_PM.png" alt={`loading-image`}  className="loading-image" />);
    } else {
      const {id, body, author, time_posted_ago, upvoter_ids, upvoted, downvoted, commentIds} = answer;
      let answerBody;

      if(downvoted) {
        answerBody = <div><h2></h2>You downvoted this answer.<h3>Downvoting low-quality content improves Insignia Community for everyone.</h3></div>
      } else {
        if(this.state.editOpen) {
          answerBody = <AnswerEditFormContainer answerId={id} body={body} closeEditForm={this.closeEditForm}/>
        } else {
          const parsedHTML = ReactHtmlParser(body)
          if (this.state.isExpanded) {
            answerBody = parsedHTML
          }
          else {
            answerBody = (
              <div>
                <TruncateMarkup lines={3} onAfterTruncate={(wasTruncated)=>this.setState({ needTruncation: wasTruncated })}>
                  <div>
                    {parsedHTML}
                  </div>
                </TruncateMarkup>
                {this.state.needTruncation && <a onClick={()=>this.handleAnswerExpand()}>(more)</a>}
              </div>
            )
          }
        }
      }
      const editButton = answer.author.id === user.id ?
        <button className="edit-answer-button" onClick={()=>this.openEditForm(body, answer.id)}>
          <div className="edit-answer-text">Edit Answer</div>
        </button> : null;

      return (
        <li className="answer-item">
          <div className="answer-header">
            <img src={author.pro_pic_url} alt={`${author.name}'s picture`}  className="answerer-pro-pic" />
            <div className="answer-details">
              <h1>{author.name}</h1>
              <h2>Answered {time_posted_ago}</h2>
            </div>
          </div>
          <div className="answer-body">
              {answerBody}
          </div>

          <div className="answer-buttons">
            <AnswerVoteButtonContainer id={id} upvoterIds={upvoter_ids} upvoted={upvoted} downvoted={downvoted}/>
            <button className="comments-button" onClick={()=>this.setState({commentOpen: !this.state.commentOpen})}>Comments {commentIds.length}</button>

            {editButton}
          </div>
          {this.comments(id, commentIds)}
        </li>
      );
    }
  }
}

export default AnswerItem;
