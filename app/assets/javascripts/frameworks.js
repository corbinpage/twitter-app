$(".application.frameworks").ready(function(){
  if($("body").hasClass('frameworks')) {
    // setTimeout(getNewFrameworkTweets,1000);  

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
                animation: Highcharts.svg,
                marginRight: 10,
                events: {
                    // load: function() {
    
                    //     // set up the updating of the chart each second
                    //     var series = this.series[0];
                    //     setInterval(function() {
                    //         var x = (new Date()).getTime(), // current time
                    //             y = 5 * Math.random();
                    //         series.addPoint([x, y], true, true);
                    //     }, 1000);
                    // }
                    load: function() {    
                        // set up the updating of the chart each second
                        var series1 = this.series[0];
                        var series2 = this.series[1];
                        var series3 = this.series[2];
                        var series4 = this.series[3];
                        // var series5 = this.series[4];
                        setTimeout(updateChartData,1000);  
                          function updateChartData(){
                                var x;
                                $.getJSON("frameworks_update.json?", function(data){
                                    if(data['id']!=-1) {
                                      console.log(data)
                                      x = (new Date()).getTime(); 
                                      // x = data['read_time']; 
                                      series1.addPoint([x, data['java']], true, true);
                                      series2.addPoint([x, data['ruby']], true, true);
                                      series3.addPoint([x, data['php']], true, true);
                                      series4.addPoint([x, data['python']], true, true);
                                      // series5.addPoint([x, data['amazon']], true, true);
                                    }
                                    else {
                                      console.log("Skipped: "+ data['id'])
                                    }
                                });
                            setTimeout(updateChartData,1000);  
                          }
                    }
                }
            },
            title: {
                text: 'Mentioned Languages on Twitter'
            },
            xAxis: {
                title: {
                    text: 'Number of Mentions in Last Hour'
                },
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
                    text: 'Number of'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                        return '<b>'+ this.series.name +' ' + this.y + '</b><br/>'+
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x);
                }
            },
            legend: {
                enabled: true
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: 'Java',
                data: (function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;
    
                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: 0
                        });
                    }
                    return data;
                })(),
                marker: {enabled: false}
            },
            {
                name: 'Ruby',
                data: (function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;
    
                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: 0
                        });
                    }
                    return data;
                })(),
                marker: {enabled: false}
            },
            {
                name: 'PHP',
                data: (function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;
    
                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: 0
                        });
                    }
                    return data;
                })(),
                marker: {enabled: false}
            },
            {
                name: 'Python',
                data: (function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;
    
                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: 0
                        });
                    }
                    return data;
                })(),
                marker: {enabled: false}
            }
            // ,{
            //     name: 'Amazon',
            //     data: (function() {
            //         // generate an array of random data
            //         var data = [],
            //             time = (new Date()).getTime(),
            //             i;
    
            //         for (i = -19; i <= 0; i++) {
            //             data.push({
            //                 x: time + i * 1000,
            //                 y: 0
            //             });
            //         }
            //         return data;
            //     })(),
            //     marker: {enabled: false}
            // }
            ]
        });
    });
    
});




  }
});
