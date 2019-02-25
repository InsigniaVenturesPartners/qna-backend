import React from 'react';
import ReactDOM from 'react-dom';
import Modal from 'react-modal';
import { Link, withRouter } from 'react-router-dom';

import Checkbox from 'muicss/lib/react/checkbox';

import { customStyles, cancelStyles } from '../create_question_form/create_question_form';
import QuestionSearchContainer from '../question_search/question_search_container';

class AdminNavBar extends React.Component {
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

  componentWillMount() {
    if (this.props.user.role !== "admin") {
      this.props.history.push('/');
    }
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
    const {user} = this.props

    return(
      <div>
        <div className="ribbon ribbon-main">BETA</div>
        <div className="nav-bar desktop-only">
          <ul className="nav-bar-items">
            <li id="nav-home" className={"nav-link " + (this.props.location.pathname == "/admin" ? "highlighted" : "")} >
              <Link to={`/admin`}>
                <i className="fa fa-user"></i>
                Whitelist
              </Link>
            </li>


            <li id="nav-pro-pic">
              <Link to={`/admin`}>
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
        <div className="nav-bar-mobile-wrapper">
          <div className="nav-bar mobile-only">
            <ul className="nav-bar-items">
              <li id="nav-home" className={"nav-link " + (this.props.location.pathname == "/admin" ? "highlighted" : "")} >
                <Link to={`/`}>
                  <i className="fa fa-user"></i>
                  Whitelist
                </Link>
              </li>
            </ul>
          </div>

          <div className="nav-bar mobile-only">
            <ul className="nav-bar-items">
              <li id="nav-pro-pic">
                <Link to={`/admin`}>
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

export default withRouter(AdminNavBar);
