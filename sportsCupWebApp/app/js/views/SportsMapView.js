google.load( 'visualization', '1', { packages:['corechart'] });

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
};

$( initialize );

