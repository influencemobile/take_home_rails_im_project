import React from "react"
import PropTypes from "prop-types"
import BootstrapTable from 'react-bootstrap-table-next';
import paginationFactory from 'react-bootstrap-table2-paginator';
import filterFactory, { textFilter, Comparator } from 'react-bootstrap-table2-filter';
import cellEditFactory from 'react-bootstrap-table2-editor';

class Home extends React.Component {
  constructor(props) {
    super(props);
    // this.ageRef = React.createRef();
    // this.genderRef = React.createRef();
    this.state = {
        players:            [],
        offers:             [],
        offersTargets:      [],
        offersWithTargets:  [],
        selectedRow:        [],
        playerEditable:     false
    };
    
    this.genderInput = null; 
    this.ageInput    = null;
    
    this.filterAgeGender = this.filterAgeGender.bind(this);
    this.cleanAgeGenderFlter = this.cleanAgeGenderFlter.bind(this);
    
    this.onPlayerSelect   = this.onPlayerSelect.bind(this);
    this.getAge           = this.getAge.bind(this);
    // this.handleAgeRef     = this.handleAgeRef.bind(this);
    // this.handleGenderRef  = this.handleGenderRef.bind(this);

    this.handlePlayerEdit = this.handlePlayerEdit.bind(this);

  }
  
  componentDidMount(){
    console.log("[Home][componentDidMount]");
    
    // Fetch all data, Player, Offers, OffersTargets
    this.fetchAll();
  }

  getAge(dateString) {
    const today = new Date();
    const birthDate = new Date(dateString);
    let age = today.getFullYear() - birthDate.getFullYear();
    const month = today.getMonth() - today.getMonth();
    if ( month < 0 || ( month === 0 && today.getDate() < birthDate.getDate()) ) {
      age -= 1
    }
    return age.toString();
  }


  onPlayerSelect({ id, gender, age }, isSelected) {
    let selectedRow = []
    selectedRow['gender'] = gender;
    selectedRow['age'] = this.getAge(age);

    this.setState({
      selectedRow: selectedRow
     }, () => {
      console.log(this.state.selectedRow);
      this.filterAgeGender();
     });
  }

  fetchAll(){
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
  
  // handleGenderRef(ref){
  //   this.genderInput = ref
  // }

  // handleAgeRef(ref){
  //   this.ageInput = ref
  // }

  // Handle filter Event from Button click or select player
  filterAgeGender(){
    console.log("[filterAgeGender]");
    this.ageFilter(this.state.selectedRow['age'])
    this.genderFilter(this.state.selectedRow['gender']);
    
  }

  cleanAgeGenderFlter(){

    let selectedRow = []
    selectedRow['gender'] = "";
    selectedRow['age'] = "";

    this.setState({
      selectedRow: selectedRow
     }, () => {
      console.log(this.state.selectedRow);
      this.filterAgeGender();
     });

    // this.genderFilter(this.state.selectedRow['gender']);
    // this.ageFilter(this.state.selectedRow['age'])
  }

  handlePlayerEdit(){
    // assume update player id 3
    console.log("[Home][handlePlayerEdit]");

    let player = {
      id: 3,
      first_name: "Taco",
      gender: "Male"
    }
    fetch(`/api/v1/players/3`, 
    {
      method: 'PUT',
      body: JSON.stringify({player: player}),
      headers: {
        'Content-Type': 'application/json'
      }
    }).then((response) => { 
        // this.updateFruit(fruit)
      })
  }

  render () {

    var nameFilter;

    const columns = [{
        dataField: 'id',
        text: 'Product ID'
      }, {
        dataField: 'name',
        text: 'Product Name'
      }, {
        dataField: 'price',
        text: 'Product Price'
    }];

    const playerColumns = [{
      dataField: 'id',
        text: 'Player ID',
        hidden: true
      }, {
        dataField: 'first_name',
        text: 'Player Name'
      }, {
        dataField: 'age',
        text: 'Player age'
      }, {
        dataField: 'gender',
        text: 'Player gender'
    }];

    const offersColumns = [{
      dataField: 'id',
        text: 'Offer ID'
      }, {
        dataField: 'description',
        text: 'Offer description',
        sort: true
      }, {
        dataField: 'age',
        text: 'Offer age',
        sort: true,
        filter: textFilter({
          comparator: Comparator.EQ,
          getFilter: (filter) => this.ageFilter = filter
        })
      }, {
        dataField: 'gender',
        text: 'Offer gender',
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
      onSelect: this.onPlayerSelect
    };
    
    return (
      <React.Fragment>
        <nav className="navbar navbar-light bg-light">
          <a className="navbar-brand" href="/">IM Offers</a>
            Greeting: {this.props.greeting}
        </nav>
        <div className="container">
          <div className="row gx-5">
            <div className="col-12">
              <button className="btn btn-lg btn-primary" onClick={ this.cleanAgeGenderFlter }> Clean filter </button>
              
              <hr></hr>
              <button onClick={() => this.handlePlayerEdit()} >{this.state.playerEditable? 'Submit' : 'Edit'}</button>
              <BootstrapTable 
                keyField='id' 
                data={ this.state.players } 
                columns={ playerColumns } 
                bordered={ false }  
                pagination={ paginationFactory() }
                selectRow={ selectPlayersProp }
                cellEdit={ cellEditFactory({ 
                  mode: 'dbclick',
                  blurToSave: true
                }) }
              />
              <hr></hr>
              <BootstrapTable 
                keyField='id' 
                data={ this.state.offersWithTargets } 
                columns={ offersColumns } 
                bordered={ false }  
                pagination={ paginationFactory() }
                filter={ filterFactory() }
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
