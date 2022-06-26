/* eslint-disable no-debugger */
import React from 'react';
import ReactDOM from 'react-dom';

import PopUp from '../bundles/popUp/root';

window.MarkSingCoaching = (() => {

  //INIT
  function initialize(embeddableId) {
    const embeddable = <PopUp
      open={false}
      stopPopUp={true}
    />;
    const embeddableContainer = document.body.appendChild(document.createElement('div'))
    ReactDOM.render(embeddable, embeddableContainer)
  }


  function launchPopUp(url) {
    var popUpEvent = new CustomEvent("launchPopUp", { detail: url });
    document.body.dispatchEvent(popUpEvent);
  }

  //PUBLIC
  return {
    initialize: initialize,
    launchPopUp: launchPopUp
  }
})()

window.MarkSingCoaching.initialize()