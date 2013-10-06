google.load( 'visualization', '1', { packages:['corechart'] });

/*
 * Gets year and week of football year
 */
function getWeekNumber(d) {
  // Copy date so don't modify original
  d = new Date(d);
  d.setHours(0,0,0);
  // Set to nearest Thursday: current date + 4 - current day number
  // Make Sunday's day number 7
  d.setDate(d.getDate() + 4 - (d.getDay()||7));
  // Get first day of year
  var yearStart = new Date(d.getFullYear(),0,1);
  // TODO: Figure out week of football season, hardcode 7 for now
  var weekNo = 5;
  // Return array of year and week number
  return [d.getFullYear(), weekNo];
}

function ChartMarker( options ) {

  this.$inner = $('<div>').css({
    position: 'relative',
    left: '-50%', top: '-50%',
    width: options.width,
    height: options.height,
    fontSize: '1px',
    lineHeight: '1px',
    padding: '2px',
    cursor: 'default'
  });

  this.$div = $('<div>')
    .append( this.$inner )
    .css({
      position: 'absolute',
      display: 'none'
    });
};

ChartMarker.prototype.onAdd = function() {
  $( this.getPanes().overlayMouseTarget ).append( this.$div );
};

ChartMarker.prototype.onRemove = function() {
  this.$div.remove();
};

ChartMarker.prototype.draw = function(data, options) {
  var marker = this;

  this.chart = new google.visualization.PieChart( document.getElementById('pie-chart') );

  this.chart.draw( data, options );
};

function initialize() {

  google.maps.visualRefresh = true;

  var latLng = new google.maps.LatLng( 37.7833, -122.4167 );

  var map = new google.maps.Map( $('#map-canvas')[0], {
    zoom: 11,
    center: latLng,
    panControl: false,
    zoomControl: false,
    mapTypeControl: false,
    scaleControl: false,
    streetViewControl: false,
    overviewMapControl: false,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  // get todays date
  var today = new Date();

  // get array with year and week number
  var yearWeekArray = getWeekNumber(today);

  $.ajax({
    url: 'tweets/nfl',
    type: 'POST',
    success: function(requestData) {

      var games = []
      // set first entry in games array to header titles
      games.push(['Game', 'Twitter Interest'])
      var found, gameInfo, gameName;
      // Contruct hash of games and counts of number of tweets
      for (x in requestData) {
        gameInfo = requestData[x]
        // check if game has alredy been added to hash
        gameName = gameInfo.game_info.away_team + ' at ' +  gameInfo.game_info.home_team
        found = false;
        for (y in games) {
          // if game has already been found increment
          if ( games[y][0] === gameName ) {
            games[y][1] = games[y][1] + 1;
            found = true;
          }
        }
        // if game was not found in current list, add entry for it
        if (found === false) {
          game = [];
          game[0] = gameName;
          game[1] = 1;
          games.push(game);
        }
      }

      var data = google.visualization.arrayToDataTable(games);

      var options = {
        fontSize: 11,
        legend: 'none',
        pieSliceText: 'label',
        backgroundColor: 'transparent'
      };

      var marker = new ChartMarker({
        events: {
          click: function( event ) {
            alert( 'Clicked marker' );
          }
        }
      });


      marker.draw(data, options);

    },
    error: function(xhr, textStatus, errorThrown) {
      alert("Error Loading data " + errorThrown);
    },
    contentType: "application/json; charset=utf-8",
    dataType: 'json',
    data: '{"year":' + yearWeekArray[0] + ', "week":' + yearWeekArray[1] + '}'
  });

  $.ajax({
    url: 'establishments',
    type: 'POST',
    success: function(requestData) {

      // get list of establishment objects
      var establishments = requestData.features;
      var markers = [];
      var infoWindows = [];
      var establishment, lng, lat, latLng, eventText;

      // for each establishment create map marker with event text
      for (x in establishments) {
        establishment = establishments[x];
        lng = establishment.geometry.coordinates[0];
        lat = establishment.geometry.coordinates[1];
        latLng = new google.maps.LatLng(lat, lng);
        // get establish name and content
        eventText = '<div class="info-window"><div id="info-header">' + establishment.properties.name
          + '</div><div id="info-content">' + establishment.properties.events.join(" ") + '</div></div>';

        infoWindows.push ( new google.maps.InfoWindow({
          content: eventText
        }));

        markers.push( new google.maps.Marker({
          position: latLng,
          map: map
        }));

        google.maps.event.addListener(markers[x], 'click', function (a) {
          return function() {
            infoWindows[a].open(map,markers[a]);
          }
        }(x));

      }
    },
    error: function(xhr, textStatus, errorThrown) {
      alert("Error Loading data " + errorThrown);
    },
    contentType: "application/json; charset=utf-8",
    dataType: 'json'
  });


};

$( initialize );

