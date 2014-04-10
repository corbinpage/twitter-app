
var markers = [];
var after = 1;
var heat = [];
var map;
var heatmap;

function injectMap(){

    var myLatlng = new google.maps.LatLng(40.7055269, -74.014346);
    
    var myOptions = {
      zoom: 12,
      center: myLatlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      disableDefaultUI: false,
      scrollwheel: true,
      draggable: true,
      navigationControl: true,
      mapTypeControl: false,
      scaleControl: true,
      disableDoubleClickZoom: false
    };
    
    var map = new google.maps.Map($("#heatmapArea")[0], myOptions);

        map.set('styles', styleSet(0));

    var heatmap = new HeatmapOverlay(map, {
        "radius":20,
        "visible":true, 
        "opacity":60
    });
 

    var testData={
            max: 46,
            data: [
            {lat: 40.7055269, lng:-74.014346, count: 1}
            ]
    };


    heatmap = new HeatmapOverlay(map, {"radius":15, 
      "visible":true, 
      "opacity":50,
      "gradient": { 1.0: "rgb(0,0,255)", 0.55: "rgb(0,255,255)", 0.65: "rgb(0,255,0)", 0.95: "yellow", 1.0: "rgb(255,0,0)"}
    });

    setTimeout(getNewTweets,1000);  
    
    function getNewTweets(){
      console.log(after);
      $.getJSON("update.json?after=" + after, function(data){
          console.log(data)
          if(data['id'] != -1) { 
            if (data['has_geo']) {
              if (data[''])
            console.log(after);
            after = data['id'];
            heatmap.addDataPoint(data['lat'],data['lng'],100);
          }
        }
      });
      setTimeout(getNewTweets,1000);  
    }

    function makeMarker(data) {
        marker = new google.maps.Marker({
          position: new google.maps.LatLng(data['lat'], data['lng']),
          map: map,
          zIndex: 100,
          icon: "http://maps.google.com/mapfiles/dir_39.png"
        });
      markers.push(marker);
    }
    
    document.getElementById("tog").onclick = function(){
      heatmap.toggle();
    };

      var testData={
            max: 46,
            data: [{lat: 440.7055269, lng:-74.014346, count: 1}], 
          };
        
      
      google.maps.event.addListenerOnce(map, "idle", function(){
        heatmap.setDataSet(testData);
      });

    pulse();

    function pulse () {
      pulseDown(30);
    }

    function pulseDown (num) {
      if (num > -50){
        map.set('styles', styleSet(num));
        setTimeout(function() {pulseDown(num - 20)},100)
      } else {
        pulseUp(num);
      }
    }

    function pulseUp (num) {
      if (num < 0){
        map.set('styles', styleSet(num));
        setTimeout(function() {pulseUp(num + 20)},325)
      } else {
        pulseDown(num);
      }
    }

    function styleSet (num) {
      num = typeof num !== 'undefined' ? num : 0;

      return [
        {
          featureType: 'water',
          stylers: [
            { saturation: -90 },
            { lightness: 90 },
            { color: '#ffcccc' }
          ]
        }, {
          featureType: 'administrative',
          elementType: 'geometry',
          stylers: [
            { "color": "#ffdddd" },
            { "weight": 1 }
          ]
        }, {
          stylers: [
            { "hue": "#ff2080" },
            { "saturation": num },
            { "invert_lightness": true }
          ]
        }, {
          featureType: 'road',
          stylers: [
            { "hue": "#ff005d" },
            { "visibility": "off" }
          ]
        }
      ]
    }
  
}
$(document).ready(function(){
    

});