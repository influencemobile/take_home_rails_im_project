import React, {useState} from "react"
import PropTypes from "prop-types"
import BootstrapTable from 'react-bootstrap-table-next';
import cellEditFactory from 'react-bootstrap-table2-editor';
import paginationFactory from 'react-bootstrap-table2-paginator';
import filterFactory, { textFilter, Comparator } from 'react-bootstrap-table2-filter';
// const cellEditFactory = require('react-bootstrap-table2-editor');

class Home extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        players:            [],
        offers:             [],
        offersTargets:      [],
        offersWithTargets:  [],
        selectedRow:        []
    };
  }
  
  componentDidMount(){
    // Fetch all data, Player, Offers, OffersTargets
    this.fetchAllHelper();
  }

  // Helper Function for calculate age by birth
  getAgeHelper =(dateString) => {
    const today = new Date();
    const birthDate = new Date(dateString);
    let age = today.getFullYear() - birthDate.getFullYear();
    const month = today.getMonth() - today.getMonth();
    if ( month < 0 || ( month === 0 && today.getDate() < birthDate.getDate()) ) {
      age -= 1
    }
    return age.toString();
  }

  // Helper Function for fetch players, offers, offers_target data from backend, and write it to state
  fetchAllHelper = () => {
    Promise.all([
      fetch('/api/v1/players'),
      fetch('/api/v1/offers'),
      fetch('/api/v1/offers_targets')
    ]).then(function (responses) {
      return Promise.all(responses.map(function (response) {
        return response.json();
      }));
    }).then(
      ([players, offers, offersTargets]) => {
        this.setState({
          players:        players,
          offers:         offers,
          offersTargets:  offersTargets
        }, () => {
          const a1 = this.state.offersTargets;
          const a2 = this.state.offers;
          const a3 = a1.map(t1 => ({...t1, ...a2.find(t2 => t2.id === t1.offer_id)}));
          this.setState({ offersWithTargets: a3 });
        });
      }
    ).catch(function (error) {
      console.log(error);
    });
  }

  // Helper Function for change selectedRow state
  changeSelectedRowHelper = (id, gender, age) => {
    let selectedRow = []
    selectedRow['id'] = id;
    selectedRow['gender'] = gender;
    selectedRow['age'] = age == "" ? age : this.getAgeHelper(age);

    this.setState({
      selectedRow: selectedRow
     }, () => {
      this.filterAgeGender();
     });
  }
  
  // Player table - when select a player row
  onPlayerSelect = ({ id, gender, age }, isSelected) => {
    this.changeSelectedRowHelper(id, gender, age);
  }

  // Handle filter Event from Button click or select player
  filterAgeGender = () => {
    // console.log("[filterAgeGender]");
    this.ageFilter(this.state.selectedRow['age'])
    this.genderFilter(this.state.selectedRow['gender']);
  }

  cleanAgeGenderFlter = () => {
    this.changeSelectedRowHelper("", "", "");
  }

  handlePlayerEdit = () => {
    
    const selectedPlayer = this.state.selectedRow;
    if (selectedPlayer["id"] === "" || typeof selectedPlayer["id"] === 'undefined') {
      console.log(" Select a Player first");
      alert("Select a Player from Player first!!");
    } else {
      this.submitPlayerEdit();
    }
  }

  submitPlayerEdit(){
    let player = {
      id: this.state.selectedRow["id"]
    }
    fetch(`/api/v1/players/` + this.state.selectedRow["id"], 
    {
      method: 'PUT',
      body: JSON.stringify({player: player}),
      headers: {
        'Content-Type': 'application/json'
      }
    }).then((response) => { 
      return response.json();
    }).then((data) => {
      // Fetch all data
      this.fetchAllHelper();
      return data;
    }).then((data) => {
      this.changeSelectedRowHelper(data.id.toString(), data.gender, data.age);
    });
  }

  ageFormatter = (cell, row) => {
    return (
      <span>{ cell } ( { this.getAgeHelper(cell) } yr )</span>
    );
  }

  genderFormatter = (cell, row) => {
    let colorLabel = "";
    if ( cell === "Female" ) {
      colorLabel = "label label-danger"
    } else if ( cell === "Female" ) {
      colorLabel = "label label-primary"
    } else {
      colorLabel = "label label-default"
    }
    return (
      <span className={colorLabel}>{ cell }</span>
    );
  }

  render () {

    const playerColumns = [{
      dataField: 'id',
        text: 'Player ID',
        hidden: true
      }, {
        dataField: 'first_name',
        text: 'First Name',
        headerAlign: 'center',
        sort: true
      }, {
        dataField: 'gender',
        text: 'Gender',
        align: 'center',
        headerAlign: 'center',
        sort: true
      }, {
        dataField: 'age',
        text: 'Age',
        formatter: this.ageFormatter,
        headerAlign: 'center',
        sort: true
    }];

    const offersColumns = [{
      dataField: 'id',
        text: 'Offer ID',
        hidden: true
      }, {
        dataField: 'description',
        text: 'Offer Description',
        headerAlign: 'center',
        sort: true
      }, {
        dataField: 'age',
        text: 'Offer Target age',
        align: 'center',
        headerAlign: 'center',
        sort: true,
        filter: textFilter({
          comparator: Comparator.EQ,
          getFilter: (filter) => this.ageFilter = filter
        })
      }, {
        dataField: 'gender',
        text: 'Offer Target gender',
        align: 'center',
        headerAlign: 'center',
        sort: true,
        filter: textFilter({
          comparator: Comparator.EQ,
          getFilter: (filter) => this.genderFilter = filter
        })
    }];

    // const selectOffersProp = {
    //   // mode: 'radio',
    //   clickToSelect: true,
    //   clickToEdit: true,
    //   hideSelectColumn: true
    //   // onSelect: this.onPlayerSelect
    // };

    const selectPlayersProp = {
      mode: 'radio',
      clickToSelect: true,
      clickToEdit: true,
      hideSelectColumn: true,
      bgColor: (row, rowIndex) => ('#00BFFF'),
      onSelect: this.onPlayerSelect
    };
    
    const PlayerCaptionElement = () => <h3 style={{ borderRadius: '0.25em', textAlign: 'center', color: 'purple', border: '1px solid purple', padding: '0.2em' }}>Players</h3>;
    const OfferTargetCaptionElement = () => <h3 style={{ borderRadius: '0.25em', textAlign: 'center', color: 'purple', border: '1px solid purple', padding: '0.2em' }}>IM Offers</h3>;

    return (
      <React.Fragment>
        <nav className="navbar navbar-light bg-light">
          <a className="navbar-brand" href="/">IM Offers</a>
            Greeting: {this.props.greeting}
        </nav>
        <div className="container">
          <div className="row gx-5">
            <div className="col-12">
              <hr></hr>
              {/* <button className="btn btn-lg btn-primary" style={{marginRight: "16px", marginBottom: "16px"}} onClick={ this.cleanAgeGenderFlter }> Clean filter </button>  */}
              <button className="btn btn-lg btn-primary" style={{marginBottom: "16px"}} onClick={ () => this.handlePlayerEdit()} >Edit selected Player with random first_name, age, and gender</button>
              {/* <div style={{paddingTop: "20px"}}></div> */}
            </div>
            <div className="col-6">
              <BootstrapTable 
                keyField='id' 
                data={ this.state.offersWithTargets } 
                columns={ offersColumns } 
                bordered={ false }  
                pagination={ paginationFactory() }
                filter={ filterFactory() }
                caption={<OfferTargetCaptionElement />}
                bootstrap4
                hover
              />
              
            </div>
            <div className="col-6">
              <BootstrapTable 
                keyField='id' 
                caption={<PlayerCaptionElement />}
                data={ this.state.players } 
                columns={ playerColumns } 
                bordered={ false }  
                pagination={ paginationFactory() }
                selectRow={ selectPlayersProp }
                cellEdit={ cellEditFactory({ mode: 'dbclick' }) }
                hover
                bootstrap4
                
              />
              
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
