import React from "react"
import PropTypes from "prop-types"

class Home extends React.Component {
  render () {
    return (
      <React.Fragment>
        <nav class="navbar navbar-light bg-light">
          <a class="navbar-brand" href="/">IM Offers</a>
            Greeting: {this.props.greeting}
        </nav>
        <div className="container">
          <div className="row gx-5">
            <div className="col-12">
              123
            </div> {/* End of col */}
          </div> {/* End of row */}
        </div> {/* End of container */}
      </React.Fragment>
    );
  }
}

Home.propTypes = {
  greeting: PropTypes.string
};
export default Home
