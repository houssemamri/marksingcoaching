import PropTypes from 'prop-types';
import React from 'react';

export default class Loading extends React.Component {

  style() {
    return {
      height: '100%',
      width: '100%',
      textAlign: 'center',
      padding: '20px',
      paddingBottom: '30px',
    }
  }

  render() {
    return (
      <div style={ this.style() }>
        <img src="https://www.commercy.io/spinner.gif" width='40'/>
      </div>
    );
  }
}
