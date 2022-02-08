import React, { useState, useEffect } from "react"
import axios from 'axios'
import PropTypes from "prop-types"
import BootstrapTable from 'react-bootstrap-table-next';
import cellEditFactory from 'react-bootstrap-table2-editor';
import paginationFactory from 'react-bootstrap-table2-paginator';
import filterFactory, { textFilter, Comparator } from 'react-bootstrap-table2-filter';
import faker from 'faker';

let ageFilterNew = "";
let genderFilterNew = "";

function Home() {
  // Declare a new state variable
  const [players, setPlayers]             = useState([]);
  const [offers, setOffers]               = useState([]);
  const [selectedRow, setSelectedRow]     = useState([]);

  // like componentDidMount()
  useEffect(() => {
    getAllPlayers();
    getAllOffers();
  }, []);

  useEffect(() => {
    filterAgeGender();
  }, [selectedRow]);


  // Helper Function for calculate age by birth
  const getAgeHelper = (dateString) => {
    const today = new Date();
    const birthDate = new Date(dateString);
    let age = today.getFullYear() - birthDate.getFullYear();
    const month = today.getMonth() - today.getMonth();
    if ( month < 0 || ( month === 0 && today.getDate() < birthDate.getDate()) ) {
      age -= 1
    }
    return age.toString();
  }

  const getAllPlayers = () => {
    axios.get('/api/v1/players')
      .then(response => {
        setPlayers(response.data);
      })
      .catch( error => {
        console.log(error.response.data.error);
      });
  }

  const getAllOffers = () => {
    axios.get('/api/v1/offers')
      .then(response => {
        setOffers(response.data);
      })
      .catch( error => {
        console.log(error.response.data.error);
      });
  }

  // Helper Function for fetch players, offers, offers_target data from backend, and write it to state
  // const fetchAllHelper = () => {
  //   Promise.all([
  //     // fetch('/api/v1/players'),
  //     fetch('/api/v1/offers'),
  //     // fetch('/api/v1/offers_targets')
  //   ]).then(function (responses) {
  //     return Promise.all(responses.map(function (response) {
  //       return response.json();
  //     }));
  //   }).then(
  //     ([players, offers, offersTargets]) => {
  //       // setPlayers(players);
  //       // setOffers(offers);
  //       // setOffersTargets(offersTargets);

  //       // const a3 = offersTargets.map(t1 => ({...t1, ...offers.find(t2 => t2.id === t1.offer_id)}));
  //       // setOffersWithTargets(a3);
  //     }
  //   ).catch(function (error) {
  //     console.log(error);
  //   });
  // }

  // Helper Function for change selectedRow state
  const changeSelectedRowHelper = (id, gender, age) => {
    let selectedRow = []
    selectedRow['id'] = id;
    selectedRow['gender'] = gender;
    selectedRow['age'] = age == "" ? age : getAgeHelper(age);
    setSelectedRow(selectedRow);
  }
  
  // Player table - when select a player row
  const onPlayerSelect = ({ id, gender, age }, isSelected) => {
    changeSelectedRowHelper(id, gender, age);
  }

  // Handle filter Event from Button click or select player
  const filterAgeGender = () => {
    ageFilterNew(selectedRow["age"]);
    genderFilterNew(selectedRow['gender']);
  }

  const cleanAgeGenderFlter = () => {
    changeSelectedRowHelper("", "", "");
  }

  const handlePlayerEdit = () => {
    const selectedPlayer = selectedRow;
    if (selectedPlayer["id"] === "" || typeof selectedPlayer["id"] === 'undefined') {
      console.log(" Select a Player first");
      alert("Select a Player from Player first!!");
    } else {
      submitPlayerEdit();
    }
  }

  const submitPlayerEdit = () => {
    const date_between = faker.date.between('1956-01-01','2003-01-01');
    const player = {
      id: selectedRow["id"],
      gender: faker.random.number({'min': 1, 'max': 10}) % 2 === 0 ? 'Female' : 'Male',
      age: new Date(date_between).toUTCString(),
      first_name: faker.name.findName() 
    }
    axios.put('api/v1/players/' + selectedRow["id"], player )
      .then(response => {
        getAllPlayers();
        changeSelectedRowHelper(response.data.id.toString(), response.data.gender, response.data.age);
      })
      .catch(error => {
        console.log(error.response.data.error);
      });
  }

  const ageFormatter = (cell, row) => {
    return (
      <span>{ cell } ( { getAgeHelper(cell) } yr )</span>
    );
  }

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
      formatter: ageFormatter,
      headerAlign: 'center',
      sort: true
  }];

  const offersColumns = () =>  [{
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
        getFilter: (filter) => {
          ageFilterNew = filter
        }
      })
    }, {
      dataField: 'gender',
      text: 'Offer Target gender',
      align: 'center',
      headerAlign: 'center',
      sort: true,
      filter: textFilter({
        comparator: Comparator.EQ,
        getFilter: (filter) => {
          genderFilterNew = filter;
        }
      })
  }];

  const selectPlayersProp = {
    mode: 'radio',
    clickToSelect: true,
    clickToEdit: true,
    hideSelectColumn: true,
    bgColor: (row, rowIndex) => ('#00BFFF'),
    onSelect: onPlayerSelect
  };
  
  const PlayerCaptionElement = () => <h3 style={{ borderRadius: '0.25em', textAlign: 'center', color: 'purple', border: '1px solid purple', padding: '0.2em' }}>Players</h3>;
  const OfferTargetCaptionElement = () => <h3 style={{ borderRadius: '0.25em', textAlign: 'center', color: 'purple', border: '1px solid purple', padding: '0.2em' }}>IM Offers</h3>;

  return (
    <React.Fragment>
      <nav className="navbar navbar-light bg-light">
        <a className="navbar-brand" href="/">IM Offers</a>
      </nav>
      <div className="container">
        <div className="row gx-5">
          <div className="col-12">
            <hr></hr>
            {/* <button className="btn btn-lg btn-primary" style={{marginRight: "16px", marginBottom: "16px"}} onClick={ this.cleanAgeGenderFlter }> Clean filter </button>  */}
            <button className="btn btn-lg btn-primary" style={{marginBottom: "16px"}} onClick={ () => handlePlayerEdit()} >Edit selected Player with random first_name, age, and gender</button>
            {/* <div style={{paddingTop: "20px"}}></div> */}
          </div>
          <div className="col-6">
            <BootstrapTable 
              keyField='id' 
              data={ offers } 
              columns={ offersColumns() } 
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
              data={ players } 
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

Home.propTypes = {
  greeting: PropTypes.string
};

export default Home