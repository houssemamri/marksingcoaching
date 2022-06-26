import MicroModal from 'micromodal';

window._123LeadMagnets = (function() {
  function successCallback(response) {
    if (response.success) {
      document.querySelector("#lm-widget-container .lm-success-message").style.display = "initial";
    } else {
      document.querySelector("#lm-widget-container .lm-failure-message").style.display = "initial";
    }
  }

  function errorCallback(response) {
    document.querySelector("#lm-widget-container .lm-failure-message").style.display = "initial";
  }

  function post(url, data) {
    var request = new XMLHttpRequest();
    request.open('POST', url, true);
    request.setRequestHeader('Content-Type', "application/json;charset=UTF-8" );

    request.onreadystatechange = function() {
      if(request.readyState == 3 ) {
        var response = JSON.parse(request.responseText);
        if (request.status == 200) {
          successCallback(response);
        } else {
          errorCallback(response);
        }
      }
    }

    request.send(data);
  }

  //INIT
  function initialize() {
    if (document.querySelector('#lm-modal')) {
      MicroModal.init();
    }

    document.querySelector("#lm-widget-container form").addEventListener("submit", function(e) {
      e.preventDefault();

      document.querySelector("#lm-widget-container .lm-success-message").style.display = "none";
      document.querySelector("#lm-widget-container .lm-failure-message").style.display = "none";
      
      var endpoint = this.action;
      var data = JSON.stringify({
        lead: {
          email: this.querySelector("input[name='email']").value,
          lead_capture_tool_id: this.dataset.lctId
        }
      })

      post(endpoint, data)
    })
  }

  function loadPopUp() {
    MicroModal.show('lm-modal');
  }

  initialize();

  return {
    loadPopUp: loadPopUp,
  }
})()
