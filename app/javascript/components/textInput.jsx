import PropTypes from 'prop-types';
import React from 'react';

export default class TextInput extends React.Component {

  onBlurActionHandler( event ) {
    this.props.validateResponse( this.props.identifier )
  }

  onChangeActionHandler( event ) {
    this.props.updateResponse( this.props.identifier, event.target.value );
  }

  isInvalidClass() {
    if ( ( this.props.input.valid === null ) || this.props.input.valid ) {
      return ''
    } else {
      return ' is-invalid'
    }
  }

  render () {
    return (
      <div className={ this.isInvalidClass() }>
        { this.renderAppropriateTextField() }
      </div>
    )
  }

  renderAppropriateTextField() {
    if ( this.props.type && ( this.props.type.toLowerCase() === 'longtext' ) ) {
      return (
        <textarea
          name={ this.props.name }
          placeholder={ this.props.placeholder }
          type="text"
          style={ this.style() }
          onBlur={this.onBlurActionHandler.bind( this )}
          onChange={this.onChangeActionHandler.bind( this )}
        />
      )
    } else {
      return (
        <input
          name={ this.props.name }
          placeholder={ this.props.placeholder }
          type="text"
          style={ this.style() }
          onBlur={this.onBlurActionHandler.bind( this )}
          onChange={this.onChangeActionHandler.bind( this )}
        />
      )
    }
  }

  style() {
    let styles = {
      width: '100%',
    }
    if ( this.props.input.valid === false ) {
      styles.border = '1px solid red' 
    }
    return styles
  }
}
