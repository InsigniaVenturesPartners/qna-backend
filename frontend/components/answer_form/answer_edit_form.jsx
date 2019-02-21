import React from 'react';

import ReactQuill from 'react-quill';
import Autolinker from 'autolinker';

class AnswerEditForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = { text: props.body, open: false };
    this.handleChange = this.handleChange.bind(this);
    this.submitAnswer = this.submitAnswer.bind(this);
    this.successfulSubmit = this.successfulSubmit.bind(this);
    this.customLinkReplace = this.customLinkReplace.bind(this)
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

  successfulSubmit() {
    this.props.closeEditForm();
  }

  submitAnswer() {
    this.props.editAnswer(this.state.text, this.props.answerId).then(
      this.successfulSubmit
    );
  }

  render () {
    return (
      <div className="answer-form-container">
        <div className="answer-form">
          <ReactQuill value={this.state.text}
                      onChange={this.handleChange}
                      modules={modules}
                      placeholder={"Write your answer"}/>

          <div className="answer-form-footer">
            <button className="submit-button" onClick={()=>this.submitAnswer()}>Update</button>
          </div>
        </div>
      </div>

    );
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

export default AnswerEditForm;
