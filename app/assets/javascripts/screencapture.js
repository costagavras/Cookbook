  var page = require('webpage').create();
  var system = require('system');
  //viewportSize being the actual size of the headless browser
  page.viewportSize = { width: 650, height: 1000};
  //the clipRect is the portion of the page you are taking a screenshot of
  // page.clipRect = { top: 0, left: 0, width: 1024};
  page.onError = function(msg, trace) {

    var msgStack = ['ERROR: ' + msg];

    if (trace && trace.length) {
      msgStack.push('TRACE:');
      trace.forEach(function(t) {
        msgStack.push(' -> ' + t.file + ': ' + t.line + (t.function ? ' (in function "' + t.function +'")' : ''));
      });
    }

    console.error(msgStack.join('\n'));

  };

  page.open(system.args[1], function(status) {
    // console.log('Status: ' + status);
    page.render(system.args[2]); //captures the screen
    phantom.exit();
  });
