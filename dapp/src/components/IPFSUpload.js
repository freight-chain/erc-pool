import React, { Component } from 'react';
import ipfsAPI from 'ipfs-api';
import '../styles/App.css';

class IPFSUpload extends Component {
	constructor(props) {
		super(props);
		this.state = {
			added_file_hash: null
		};
	    this.ipfsApi = ipfsAPI('localhost', '5001');
	}

	captureFile = (event) => {
	    event.stopPropagation();
		event.preventDefault();
	    const file = event.target.files[0];
	    let reader = new window.FileReader();
	    console.log(reader);
	    reader.onloadend = () => this.saveToIpfs(reader);
	    reader.readAsArrayBuffer(file);
	}
	
	saveToIpfs = (reader) => {
		let ipfsId = null;
	    const buffer = Buffer.from(reader.result);
	    this.ipfsApi.add(buffer, { progress: (prog) => console.log(`received: ${prog}`) })
	   	.then((response) => {
			console.log(response);
			ipfsId = response[0].hash;
			console.log(ipfsId);
			this.setState({added_file_hash: ipfsId});
		})
		.then(() => {
			console.log("File uploaded. hash = ", ipfsId);
		}).catch((err) => {
			console.error(err);
		});
	}

	handleSubmit = (event) => {
		event.preventDefault();	
	}

	render() {
		return (
			<div className="IPFSUpload">
			  <form id="captureMedia" onSubmit={this.handleSubmit}>
                <input type="file" onChange={this.captureFile} />
                <input type="submit" />
              </form>
            </div>
		);
	}
}

export default IPFSUpload;
