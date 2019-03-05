import React from 'react';
import {Link} from 'react-router-dom';
import ReactQuill from 'react-quill';
import Autolinker from 'autolinker';

import QuestionEditContainer from '../question/question_edit_form_container';


class AnswerForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = { text: '', open: false };
    this.handleChange = this.handleChange.bind(this);
    this.submitAnswer = this.submitAnswer.bind(this);
    this.successfulSubmit = this.successfulSubmit.bind(this);
    this.customLinkReplace = this.customLinkReplace.bind(this)
  }

  componentWillMount() {
    if(this.props.isDraft) {
      this.props.fetchQuestionDraft(this.props.questionId).then(response => {
        this.setState({ text: response.draft.body })
      });
    }
  }

  handleChange(value) {
   const newValue = Autolinker.link(value, {
    stripPrefix: false,
    stripTrailingSlash: false,
    replaceFn: this.customLinkReplace.bind(this, value)
   })
   this.setState({ text: newValue })
  }

  customLinkReplace (value, match) {
    const offset = match.getOffset()
    const length = match.getAnchorText().length
    const whitespaceIdx = value[offset + length]
    // Generate link when user adds space after typing the URL
    return (/\s+/.test(whitespaceIdx))
  }

  successfulSubmit({answer}) {
    this.props.history.push(`/answers/${answer.id}`);
  }

  submitAnswer() {
    this.props.createAnswer(this.state.text, this.props.questionId).then(
      this.successfulSubmit
    );
  }

  submitDraft() {
    this.props.saveDraft(this.state.text, this.props.questionId)
    this.setState({open: false})
  }

  render () {
    const { questionId, body, authorId, isDraft } = this.props
    const author = this.props.current_user;
    const editButton = authorId === author.id ? <QuestionEditContainer questionId={questionId} body={body}/> : null;
    const answerButtonText = isDraft ? "Edit Draft" : "Answer";

    if (this.state.open) {
      return (
        <div className="answer-form-container">
          <div className="answer-form-button">
            <button className="write-answer-button" onClick={()=>this.setState({open: true})}>{answerButtonText}</button>
            {editButton}
          </div>
          <div className="answer-form">
            <div className="answer-header">
              <img src={author.pro_pic_url} alt={`${author.name}'s picture`}  className="answerer-pro-pic" />
              <div className="answer-details">
                <h1>{author.name}</h1>
              </div>
            </div>
            <ReactQuill value={this.state.text}
                        onChange={this.handleChange}
                        modules={modules}
                        placeholder={"Write your answer"}/>

            <div className="answer-form-footer">
              <button className="submit-button" onClick={()=>this.submitAnswer()}>Submit</button>
              <button id="answer-save-draft" className="draft-link-button" onClick={()=>this.submitDraft()}>Save Draft</button>
            </div>
          </div>
        </div>

      );
    } else {
      return (
        <div className="answer-form-button">
          <button className="write-answer-button" onClick={()=>this.setState({open: true})}>{answerButtonText}</button>
          {editButton}
        </div>

      );
    }
  }
}

const modules = {
  toolbar: [
    ["bold", "italic"], // toggled buttons
    [{ list: "ordered" }, { list: "bullet" }],
    ["blockquote", "code-block"],
    ["image", "link"] // misc
  ]
};


export default AnswerForm;

