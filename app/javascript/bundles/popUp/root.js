import PropTypes from 'prop-types';
import React from 'react';
import ReactModal from 'react-modal';

import CloseButton from './closeButton';

export default class LeadGenPopUp extends React.Component {

  constructor(props) {
    super(props);
    this.state = { open: this.props.open, stopPopUp: this.props.stopPopUp, url: '' };
  }

  openModal(url) {
    this.setState({ open: true, url })
  }

  closeModal() {
    this.setState({ open: false })
  }

  componentDidMount() {
    if (!this.state.stopPopUp) {
      setTimeout(() => {
        this.openModal()
      }, 3000)//10000 )
    } else {
      document.body.addEventListener('launchPopUp', function (e) {
        this.openModal(e.detail)
      }.bind(this))
    }
  }

  render() {
    return this.renderModal()
    // if (this.props.form.position === 'popup') {
    //   return this.renderModal()
    // } else if (this.props.form.position === 'drawer') {
    //   return this.renderDrawer()
    // }
  }

  renderDrawer() {
    if (this.state.open) {
      return (
        <div style={this.drawerStyle()}>
          <div>
            <CloseButton closeModal={this.closeModal.bind(this)} />
            <div style={{ marginTop: '25px', display: 'table', width: '100%', height: '100%', backgroundColor: 'rgba(0, 0, 0, 0)' }}>
              <div style={{ display: 'table-cell', verticalAlign: 'middle', backgroundColor: 'rgba(0, 0, 0, 0)' }}>
                <p>drawer</p>
              </div>
            </div>
          </div>
        </div>
      )
    } else {
      return (
        <div style={this.drawerStyle()}>
          <p onClick={this.openModal.bind(this)}>feedback</p>
        </div>
      )
    }
  }

  drawerStyle() {
    return {
      position: 'absolute',
      bottom: '0',
      left: '50px',
      padding: '15px',
      background: 'white',
      border: '1px solid #ddd',
      borderRadius: '10px 10px 0 0',
    }
    // else {
    //   return {
    //     position: 'absolute',
    //     bottom: '-800px',
    //     left: '50px',
    //   }
    // }
  }

  renderModal() {
    // Make this screen reader friendly soon!!!
    const iframeUrl = this.state.url
    return (
      <ReactModal
        isOpen={this.state.open}
        ariaHideApp={false}
        contentLabel="Keep in touch or contact us"
        style={{
          overlay: {
            backgroundColor: 'rgba(0, 0, 0, 0.5)',
            overflow: 'scroll',
            zIndex: 999999
          },
          content: {
            color: '#000',
            maxWidth: '600px',
            margin: 'auto',
            left: '10px',
            right: '10px',
            height: '340px',
            padding: '0',
          }
        }}
      >
        <CloseButton closeModal={this.closeModal.bind(this)} />
        <div style={{ display: 'flex', width: '100%', height: '100%', backgroundColor: 'rgba(0, 0, 0, 0)' }}>
          <div style={{ flex: '1', alignSelf: 'center', backgroundColor: 'rgba(0, 0, 0, 0)' }}>
            <iframe
              src={iframeUrl}
              style={{ border: 'none', width: '100%', minHeight: '300px' }}></iframe>
          </div>
        </div>
      </ReactModal >
    );
  }
}
