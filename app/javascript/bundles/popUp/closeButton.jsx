import React from 'react';

export default class CloseButton extends React.Component {

  buttonStyle() {
    return {
      border: 'none',
      borderRadius: '100%',
      fontWeight: '800',
      position: 'absolute',
      right: '5px',
      top: '5px',
    }
  }

  render() {
    return (
      <button
        onClick={this.props.closeModal}
        style={this.buttonStyle()}
      >
        x
      </button>
    );
  }
}
