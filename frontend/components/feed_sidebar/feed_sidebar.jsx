import React from 'react';
import {Link} from 'react-router-dom';
import TopicSearchContainer from '../topic_search/topic_search_container';


class FeedSidebar extends React.Component {
  constructor(props) {
    super(props)
    this.state = {searchOpen: false}
    this.closeSearch = this.closeSearch.bind(this);
  }

  componentWillMount() {
    this.props.requestTopics();
    // this.props.updateFilter("topicQuery", "");
  }

  closeSearch() {
    this.setState({searchOpen: false});
  }

  topicSearch() {
    if(this.state.searchOpen) {
      return <TopicSearchContainer closeSearch={this.closeSearch}/>
    }
  }

  render() {
    const {topics} = this.props;
    const topicItems = topics.map( topic => (
      <li key={ "topic-" + topic.id }>
        <Link to={`/topics/${topic.id}`}>
          <div className="feed-sidebar-topic-pic">
            <img src={topic.pic_url} />
          </div>
          <div className="feed-sidebar-topic-label">
            {topic.name}
          </div>
        </Link>
      </li>
      ));

    const pathname = this.props.location.pathname;
    if(pathname === "/" || pathname.startsWith("/topics")) {
      return(
        <div className="feed-sidebar">
          <div className="feed-sidebar-header">
          </div>
          <ul className="sidebar-topic-list">
            {topicItems}
          </ul>
        </div>
      );
    } else {
      return null
    }
  }
}

export default FeedSidebar;
