$(".application.frameworks").ready(function(){
  if($("body").hasClass('frameworks')) {
    // setTimeout(getNewFrameworkTweets,1000);  
    
    // function getNewFrameworkTweets(){
    //   after = $( "#tweet_list li:last-child").attr("data-id");
    //   if(! after) {
    //     after = 1
    //   };
    //   console.log(after)
    //   $.getJSON("update.json?after=" + after, function(data){
    //       console.log(data)
    //       if(data['id'] != -1) { // Skip an update if no new tweet has come in
    //         updateViews(data);
    //       }
    //   });
    //   setTimeout(getNewFramworkTweets,1000);  
    // }
    // function updateViews(data){
    //   $("#tweet_list").append("<li data-id=" + data['id'] + ">" + data['id']+ ": Feeling " + data['sentiment_summary'] + " - " +data['text'] + "</li>")
    // }
1
$(function () {
    $(document).ready(function() {
        Highcharts.setOptions({
            global: {
                useUTC: false
            }
        });
    
        var chart;
        $('#frameworks-chart').highcharts({
            chart: {
                type: 'spline',
                animation: Highcharts.svg, // don't animate in old IE
                marginRight: 10,
                events: {
                    load: function() {
    
                        // set up the updating of the chart each second
                        var series = this.series[0];
                        setInterval(function() {
                            var x = (new Date()).getTime(), // current time
                                y = 5 * Math.random();
                            series.addPoint([x, y], true, true);
                        }, 1000);
                    }
                }
            },
            title: {
                text: 'Live random data'
            },
            xAxis: {
                type: 'datetime',                
                dateTimeLabelFormats: { // don't display the dummy year
                    month: '%e. %b',
                    year: '%b',
                    minute: '%I:%M %p',
                    hour: '%I:%M %p'
                }
            },
            yAxis: {
                title: {
                    text: 'Value'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                        return '<b>'+ this.series.name +'</b><br/>'+
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
                        Highcharts.numberFormat(this.y, 2);
                }
            },
            legend: {
                enabled: false
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: 'Random data',
                data: (function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;
    
                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: Math.random()
                        });
                    }
                    return data;
                })()
            }]
        });
    });
    
});




  }
});
