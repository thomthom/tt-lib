$(document).ready(function()
{
  var pattern = /SketchUp(?:\s+\w+)?\/(\d+\.\d+)\s\(([^)]+)\)/;
  var match = pattern.exec(navigator.userAgent);
  
  if ( match )
  {
    var version = parseFloat(match[1]);
    var os      = match[2];
    
    if ( version >= 13.0 )
    {
      $('#download a').attr('href', 'skp:launchEW@tt_lib²');
    }
  }
});