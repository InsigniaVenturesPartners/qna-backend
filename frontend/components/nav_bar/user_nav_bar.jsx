import React from 'react';
import ReactDOM from 'react-dom';
import Modal from 'react-modal';
import { Link, withRouter } from 'react-router-dom';

import Checkbox from 'muicss/lib/react/checkbox';

import { customStyles, cancelStyles } from '../create_question_form/create_question_form';
import QuestionSearchContainer from '../question_search/question_search_container';

class UserNavBar extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      createModalIsOpen: false,
      successModalIsOpen: false,
      question: "",
      asked_question: {},
      checkedTopics: new Map()
    };

    this.setQuestion = this.setQuestion.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleSuccessfulSubmit = this.handleSuccessfulSubmit.bind(this);
    this.handleChange = this.handleChange.bind(this);

    this.openModal = this.openModal.bind(this);
    // this.afterOpenModal = this.afterOpenModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
  }

  openModal(modalName) {
    let desiredState = {question: ""};
    desiredState[modalName+"ModalIsOpen"] = true;
    this.setState(desiredState);
  }


  afterOpenModal() {
    // references are now sync'd and can be accessed.
    // this.subtitle.style.color = '#f00';
  }

  closeModal(modalName) {
    let desiredState = {};
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
    this.props.createQuestion(this.state.question, Array.from(this.state.checkedTopics.keys())).then(
      question => this.handleSuccessfulSubmit(question.question)
    );
  }

  handleSuccessfulSubmit(question) {
    this.closeModal("create");
    this.setState({asked_question: question, question: "", checkedTopics: new Map()})
    this.openModal("success")
  }

  handleChange(e) {
    const item = e.target.name;
    const isChecked = e.target.checked;
    this.setState(prevState => ({ checkedItems: prevState.checkedTopics.set(item, isChecked) }));
  }

  render() {
    const {user, topics, pathname} = this.props
    const topicItems = topics.map( topic => (
      <Checkbox name={topic.name} label={topic.name} checked={this.state.checkedTopics.get(topic.name)} onChange={this.handleChange}/>
    ));

    return(
      <div>
        <div className="ribbon ribbon-main">BETA</div>
        <div className="nav-bar desktop-only">
          <ul className="nav-bar-items">
            <li id="nav-home" className={"nav-link " + (pathname == "/" ? "highlighted" : "")} >
              <Link to={`/`}>
                <i className="fa fa-home"></i>
                Home
              </Link>
            </li>

            <li id="nav-answer" className={"nav-link " + (pathname == "/answer" ? "highlighted" : "")}>
              <Link to={`/answer`}>
                <i className="fa fa-pencil-square-o"></i>
                Answer</Link>
            </li>

            <li id="nav-search">
              <QuestionSearchContainer />
            </li>

            <li id="nav-pro-pic">
              <Link to={`/profile`}>
                <img src={user.pro_pic_url} alt={`${user.name}'s picture`}  className="nav-pro-pic" />
              </Link>
            </li>

            <li id="nav-ask-question"><button onClick={()=>this.openModal("create")}>Ask Question</button></li>


            <li id="nav-sign-out">
              <form name="sign-out" method="POST" action="/users/sign_out">
                <input type="hidden" name="_method" value="delete"/>
                <label>
                  <input name="submit2" type="submit" id="submit2" value="Sign out" />
                </label>
              </form>
            </li>
          </ul>
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
          <div className="topic-modal">
            <div className="topic-modal-header">
              <h1>Select any topics that describe your question</h1>
            </div>

            <div className="topic-modal-list">
              <div className="question-form-topic-list">
                {topicItems}
              </div>
            </div>
          </div>

          <div className="question-modal-footer">
            <button id="cancel-button" onClick={()=>this.closeModal("create")}>Cancel</button>
            <button id="ask-question-button" onClick={this.handleSubmit}>Ask Question</button>
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
            <p>
              You asked: <Link onClick={()=>this.closeModal("success")} to={`/questions/${this.state.asked_question.id}`}>{this.state.asked_question.body}</Link>
            </p>
            <i className="fa fa-times" onClick={()=>this.closeModal("success")}/>
          </Modal>
        </div>
        <div className="nav-bar-mobile-wrapper">
          <div className="nav-bar mobile-only">
            <ul className="nav-bar-items">
              <li id="nav-home" className={"nav-link " + (pathname == "/" ? "highlighted" : "")} >
                <Link to={`/`}>
                  <i className="fa fa-home"></i>
                  Home
                </Link>
              </li>
              <li id="nav-answer" className={"nav-link " + (pathname == "/questions" ? "highlighted" : "")}>
                <Link to={`/answer`}>
                  <i className="fa fa-pencil-square-o"></i>
                  Answer</Link>
              </li>
              <li id="nav-ask-question"><button onClick={()=>this.openModal("create")}>Ask Question</button></li>
            </ul>
          </div>

          <div className="nav-bar mobile-only">
            <ul className="nav-bar-items">
              <li id="nav-search">
                <QuestionSearchContainer />
              </li>
              <li id="nav-pro-pic">
                <Link to={`/profile`}>
                  <img src={user.pro_pic_url} alt={`${user.name}'s picture`}  className="nav-pro-pic" />
                </Link>
              </li>
              <li id="nav-sign-out">
                <form name="sign-out" method="POST" action="/users/sign_out">
                  <input type="hidden" name="_method" value="delete"/>
                  <label>
                    <input name="submit2" type="submit" id="submit2" value="Sign out" />
                  </label>
                </form>
              </li>
            </ul>
          </div>
        </div>
      </div>
    );
  }
}

export default withRouter(UserNavBar);
