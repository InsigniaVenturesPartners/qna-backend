import React from 'react';
import { Link } from 'react-router-dom';
import Modal from 'react-modal';
import { Container, Header, Grid, Button, Pagination, Table, Input, Dropdown } from 'semantic-ui-react';

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

class UserWhitelist extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      searchName: '',
      page: 1,
      totalPages: 1,
      totalUsers: 0,
      limit: 10,
      createModalIsOpen: false,
      successModalIsOpen: false,
      user_whitelist: "",
      requested_user_whitelist: "",
    }

    this.setUserWhitelist = this.setUserWhitelist.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleSuccessfulSubmit = this.handleSuccessfulSubmit.bind(this);

    this.openModal = this.openModal.bind(this);
    this.afterOpenModal = this.afterOpenModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
  }

  componentWillMount() {
    this.props.requestUserWhitelists()
    this.calculateTotalPages()
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
    let desiredState = {user_whitelist: ""};
    desiredState[modalName+"ModalIsOpen"] = false;
    this.setState(desiredState);
  }

  setUserWhitelist(e) {
    let user_whitelist = e.target.value ? e.target.value : "";
    this.setState({ user_whitelist });
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.createUserWhitelist(this.state.user_whitelist).then(
      (user_whitelist) => this.handleSuccessfulSubmit(user_whitelist.email)
    );
  }

  handleSuccessfulSubmit(user_whitelist) {
    this.closeModal("create");
    this.setState({requested_user_whitelist: user_whitelist, user_whitelist: ""})
  }

  onPageChange(e) {
    this.setState({ page: e.activePage })
  }

  onChangeJumpPage(e) {
    this.setState({ page: e.value })
  }

  onChangeLimit(e) {
    this.setState({ limit: e.value })
  }

  onChangeSearchName(e) {
    this.setState({ searchName: e.target.value }, () => {
      this.calculateTotalPages()
    })
  }

  calculateTotalPages() {
    let users = this.props.user_whitelists
    let totalPages = Math.ceil(users.length / this.state.limit)
    let page = this.state.page
    if (page > totalPages) {
      page = totalPages
    }
    if (page < 1) {
      page = 1
    }
    this.setState({ page: page, totalPages: totalPages, totalUsers: users.length })
  }

  render () {
    const { user_whitelists } = this.props;
    if (Object.keys(user_whitelists).length === 0) {

      return(<img src="https://image.ibb.co/iYo1yw/Screen_Shot_2017_09_28_at_6_43_28_PM.png" alt={`loading-image`}  className="loading-image" />);
    } else {

      let optionLimit = [
        { key: 'litmi-10', value: 10, text: 10 },
        { key: 'litmi-15', value: 15, text: 15 },
        { key: 'litmi-20', value: 20, text: 20 },
        { key: 'litmi-50', value: 50, text: 50 }
      ]

      return (
        <div id="questions-container">
        <Container>
          <Grid columns={2} className='mt-2'>
            <Grid.Column>
              <Header as='h1'>Insignia User Whitelist</Header>
            </Grid.Column>

            <button onClick={()=>this.openModal("create")}>Add New</button>

            <Modal
              isOpen={this.state.createModalIsOpen}
              onAfterOpen={this.afterOpenModal}
              onRequestClose={()=>this.closeModal("create")}
              style={customStyles}
              contentLabel="Example Modal"
            >
              <input onChange={this.setUserWhitelist} placeholder="User Email" value={this.state.user_whitelist} autoFocus={true}/>

              <div className="question-modal-footer">
                <button id="cancel-button" onClick={()=>this.closeModal("create")}>Cancel</button>
                <button id="ask-question-button" onClick={this.handleSubmit}>Add</button>
              </div>
            </Modal>
          </Grid>

          {/* TODO
          <Grid>
            <Grid.Column mobile={16} tablet={8} computer={6}>
              <Input icon='search' placeholder='Search...' style={{ width: '100%' }} value={this.state.searchName} onChange={this.onChangeSearchName} />
            </Grid.Column>

          </Grid>
          */}
          <Grid style={{ marginTop: '0px' }}>
            <Grid.Column>
              <Table compact celled>
                <Table.Header>
                  <Table.Row>
                    <Table.HeaderCell>Email</Table.HeaderCell>
                    <Table.HeaderCell />
                  </Table.Row>
                </Table.Header>
                <Table.Body>
                  {
                    user_whitelists.map((user_whitelist, index) => {

                      return (
                        <Table.Row key={`user_whitelists${user_whitelist.id}`}>
                          <Table.Cell>
                            {user_whitelist.email}
                          </Table.Cell>

                          <Table.Cell collapsing>
                            <Button as={Link} to={`/admin/user/detail/${user_whitelist.id}`} primary icon='eye' title='Detail' />

                          </Table.Cell>
                        </Table.Row>
                      )
                    })
                  }
                </Table.Body>
                <Table.Footer>
                {
                  (this.state.totalPages > 1) && (
                    <Table.Row>
                      <Table.HeaderCell colSpan='4'>
                        Jump to page:
                        {this.renderJumpToPage()}
                      </Table.HeaderCell>
                      <Table.HeaderCell colSpan='5' textAlign='right' style={{ borderLeft: 'none' }}>
                        <Pagination
                          size='tiny'
                          activePage={this.state.page}
                          onPageChange={this.onPageChange}
                          totalPages={this.state.totalPages}
                        />
                      </Table.HeaderCell>
                    </Table.Row>
                  )
                }
                  <Table.Row>
                    <Table.HeaderCell colSpan='5' textAlign='right' style={{ borderLeft: 'none' }}>

                    </Table.HeaderCell>
                  </Table.Row>
                </Table.Footer>
              </Table>
            </Grid.Column>
          </Grid>
        </Container>
        </div>

      );

    }

  }
}

export default UserWhitelist;
