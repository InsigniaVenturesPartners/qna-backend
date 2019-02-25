import React from 'react';
import ReactDOM from 'react-dom';
import Modal from 'react-modal';
import {Link} from 'react-router-dom';

import Checkbox from 'muicss/lib/react/checkbox';

export const customStyles = {
    overlay : {
    position          : 'fixed',
    top               : 0,
    left              : 0,
    right             : 0,
    bottom            : 0,
    backgroundColor   : 'rgba(0, 0, 0, 0.65)'
  },
  content : {
    top                   : '50%',
    left                  : '50%',
    right                 : 'auto',
    bottom                : 'auto',
    marginRight           : '-50%',
    transform             : 'translate(-50%, -50%)',
    width                 : '100%',
    maxWidth              : '623px',
    heigth                : '50%',
    padding : '0'  }
};

export const cancelStyles = {
  overlay : {
  position          : 'fixed',
  top               : 0,
  left              : 0,
  right             : 0,
  bottom            : 0,
  backgroundColor   : 'rgba(0, 0, 0, 0.65)'
},
  content : {
    top                   : '15%',
    left                  : '50%',
    right                 : 'auto',
    bottom                : 'auto',
    marginRight           : '-50%',
    transform             : 'translate(-50%, -50%)',
    width                 : '100%',
    maxWidth              : '300px',
    background            :  '#FFF4C8',

    padding : '10px'  }
};

class QuestionEditForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      createModalIsOpen: false,
      successModalIsOpen: false,
      question: props.body,
      asked_question: {}
    };

    this.setQuestion = this.setQuestion.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleSuccessfulSubmit = this.handleSuccessfulSubmit.bind(this);

    this.openModal = this.openModal.bind(this);
    this.afterOpenModal = this.afterOpenModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
  }

  openModal(modalName) {
    let desiredState = {};
    desiredState[modalName+"ModalIsOpen"] = true;
    this.setState(desiredState);
  }

  afterOpenModal(modalName) {
    // references are now sync'd and can be accessed.
    // this.background.style.color = 'white';
  }

  closeModal(modalName) {
    let desiredState = {question: this.props.body};
    desiredState[modalName+"ModalIsOpen"] = false;
    this.setState(desiredState);
  }

  setQuestion(e) {
    let question = e.target.value ? e.target.value : "";
    question = question.charAt(0).toUpperCase() + question.slice(1);
    this.setState({ question });
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.editQuestion(this.state.question, this.props.questionId).then(
      question => this.handleSuccessfulSubmit(question.question)
    );
  }

  handleSuccessfulSubmit(question) {
    this.closeModal("create");
    this.setState({asked_question: question, question: question})
    this.openModal("success")
  }

  render() {
    const {user} = this.props

    return (
      <div>

        <button className="edit-answer-button" onClick={()=>this.openModal("create")}>
          <div className="edit-answer-text">Edit Question</div>
        </button>

        <Modal
          isOpen={this.state.createModalIsOpen}
          onAfterOpen={this.afterOpenModal}
          onRequestClose={()=>this.closeModal("create")}
          style={customStyles}
          contentLabel="Example Modal"
        >

        <div className="question-modal-header">
          <img src={user.pro_pic_url} alt={`${user.name}'s picture`}  className="user-pro-pic" />
          <span id="modal-username">{user.name} asks</span>
        </div>

        <input onChange={this.setQuestion} placeholder="What is your question?" value={this.state.question} autoFocus={true}/>

        <div className="question-modal-footer">
          <button id="cancel-button" onClick={()=>this.closeModal("create")}>Cancel</button>
          <button id="ask-question-button" onClick={this.handleSubmit}>Edit Question</button>
        </div>
        </Modal>


        <Modal
            id="cancel-modal"
            className="cancel-modal"
            isOpen={this.state.successModalIsOpen}
            onAfterOpen={this.afterOpenModal}
            onRequestClose={()=>this.closeModal("success")}
            style={cancelStyles}
            contentLabel="Example Modal"
          >
          <p>You asked: <Link onClick={()=>this.closeModal("success")} to={`/questions/${this.state.asked_question.id}`}>{this.state.asked_question.body}</Link>
          </p>
            <i className="fa fa-times" onClick={()=>this.closeModal("success")}/>


          </Modal>
      </div>
    );
  }
}

export default QuestionEditForm
