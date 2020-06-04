import React, { Component } from 'react';
import logo from '../logo.svg';
import '../styles/App.css';

import IPFSUpload from './IPFSUpload.js';

class App extends Component {
  constructor(props) {
      super(props);

      this.state = {
        web3: null 
      };
  }

  componentWillMount() {

  }

  render() {
    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h1 className="App-title">Welcome to React</h1>
        </header>
        <p className="App-intro">
          To get started, edt <code>src/App.js</code> and save to reload.
        </p>
        <IPFSUpload />
      </div>
    );
  }
}

export default App;