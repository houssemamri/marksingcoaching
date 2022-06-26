var widgetContainerDiv = 'embedded-widget';

gl_iframe_resizer=document.createElement('script');
gl_iframe_resizer.src='https://cdnjs.cloudflare.com/ajax/libs/iframe-resizer/3.5.15/iframeResizer.min.js';
gl_iframe_resizer.onload=iframeResizer;
document.getElementsByTagName('head')[0].appendChild(gl_iframe_resizer);

function iframeResizer(){
  iFrameResize({checkOrigin:false, contentWindowBodyMargin: 0})
}

var cssString = "background:url('http://localhost:3000/spinner.gif');background-repeat:no-repeat;background-position-y:50%;background-position-x:50%;background-size:40px;border-radius:5px;width:100%height:100%;min-width:100%;min-height:200px;"

document.getElementById(widgetContainerDiv).style.cssText = cssString;

var gl_widget_vars = {};
gl_widget_vars.src = document.getElementById(widgetContainerDiv).dataset.embedUrl;

gl_widget_vars.id = 'embedded-widget-inner';
gl_widget_vars.scrolling = 'no';
gl_widget_vars.seamless = 'no';
gl_widget_vars.frameBorder = '0';
gl_widget_vars.async = '';
gl_widget_vars.defer = '';
gl_widget_vars.width = '100%';
gl_widget_vars.scrolling = 'no';
gl_widget_vars.allowPaymentRequest = '';

var innerCssString = "";
innerCssString += "border-radius:10px;width:100%;max-height:100%;";

function glEmbedded(){
  this.embeddedFrame = document.createElement('IFRAME');
  for(var k in gl_widget_vars) this.embeddedFrame[k]=gl_widget_vars[k];
  this.load = function(){
    document.getElementById(widgetContainerDiv).appendChild(this.embeddedFrame);
    document.getElementById('embedded-widget-inner').style.cssText = innerCssString;
  }
  this.show = function(){
    innerCssString += 'display:block;'; 
    document.getElementById('embedded-widget-inner').style.cssText = innerCssString;
  }
}
    
var gl_embed_code = new glEmbedded();
gl_embed_code.load();
gl_embed_code.show();
