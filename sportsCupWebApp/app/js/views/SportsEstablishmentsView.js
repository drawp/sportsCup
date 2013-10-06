function initialize() {

  google.maps.visualRefresh = true;

  var latLng = new google.maps.LatLng( 37.7833, -122.4167 );

  var map = new google.maps.Map( $('#map-canvas')[0], {
    zoom: 12,
    center: latLng,
    panControl: false,
    zoomControl: false,
    mapTypeControl: false,
    scaleControl: false,
    streetViewControl: false,
    overviewMapControl: false,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  $.ajax({
    url: 'establishments',
    type: 'POST',
    success: function(requestData) {

      // get list of establishment objects
      var establishments = requestData.features;
      var establishment, lng, lat, latLng, eventText, marker;

      // for each establishment create map marker with event text
      for (x in establishments) {
        establishment = establishments[x];
        lng = establishment.geometry.coordinates[0];
        lat = establishment.geometry.coordinates[1];
        latLng = new google.maps.LatLng(lat, lng);
        eventText = establishment.properties.name;

        marker = new google.maps.Marker({
          position: latLng,
          map: map,
          title: eventText
        });
      }
    },
    error: function(xhr, textStatus, errorThrown) {
      alert("Error Loading data " + errorThrown);
    },
    contentType: "application/json; charset=utf-8",
    dataType: 'json',
  });


};

$( initialize );