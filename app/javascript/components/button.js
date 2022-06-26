import PropTypes from 'prop-types';
import React from 'react';

export default class Button extends React.Component {

  render() {
    if ( this.props.actionInProgress ) {
      return this.renderButtonLoading()
    } else {
      return (
        <button
          onClick={ this.props.onClick }
        >
          { this.props.action }
        </button>
      );
    }
  }

  renderButtonLoading() {
    return (
      <button>
        <img width='20' src='https://www.commercy.io/spinner.gif' style={{ margin: '0 auto' }}/>
      </button>
    );
  }
}
