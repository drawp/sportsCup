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
  var weekNo = 7;
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

  // get todays date
  var today = new Date();

  // get array with year and week number
  var yearWeekArray = getWeekNumber(today);

  $.ajax({
    url: 'tweets',
    type: 'GET',
    success: function(requestData) {

      var data = google.visualization.arrayToDataTable([
        [ 'Game', 'Interest' ],
        [ 'Michigan vs Minnesota', 254 ],
        [ 'Clemson vs Syracuse',  176],
        [ 'Oregon vs Colorado', 120 ],
      ]);

      var options = {
        title: 'College Football Interest',
        fontSize: 20,
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
    data: {"year":yearWeekArray[0], "week":yearWeekArray[1]}
  });


};

$( initialize );

