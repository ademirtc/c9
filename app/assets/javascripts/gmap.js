function initMap() {
  // Create a map object and specify the DOM element for display.
  var map = new google.maps.Map(document.getElementById('map-canvas'), {
    center: {lat: -23.558745, lng: -46.731859},
    scrollwheel: true,
    zoom: 12
  });
}