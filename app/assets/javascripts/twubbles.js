$(document).ready(function(){
if( $("body").hasClass("twubbles")) {
  // var SIZE = 8;

  var bubble = d3.layout.pack()
    .sort(null)
    .size([970, 600])
    .padding(2)
    .value(function(d) { return d.size; } );

  var svg = d3.select('#bubbles')
    .append('svg');
    // .attr('width', SIZE)
    // .attr('height', SIZE);

  var color = d3.scale.category10();

  updateBubbles();

  function updateBubbles() {
  d3.json('twubbles.json', function(error, root) {
    update(root);
  });
  setTimeout(updateBubbles, 1000);
}

function update (data){

  var data = bubble.nodes(data).filter( function(d) { return !d.children; });

  var node = svg.selectAll('.node')
    .data(data, function(d)  { return d.name; });

  //ENTER
  var enter = node.enter().append('g')
    .attr('class', 'node')
    .attr('transform', function(d) { return 'translate(' + d.x + ',' + d.y + ')'; });

  enter.append('circle')
    .attr('r', 0)
    .style('fill', 'A4BADF')
    // .style('fill', function(d) { return color(d.name); })
    .style('opacity', .9);

  enter.append('text')
    .style('opacity', 0)
    .style ('fill', 'black')
    .style('text-anchor', 'middle')
    .text(function(d) { return d.name + " ("+d.value+")"; });

  // UPDATE
  var update = node.transition()
    .attr('transform', function(d) { return 'translate(' + d.x + ',' + d.y + ')'; });
  
  // update.bubble.size([$('.wrap').height(),$('.wrap').width()]);
  // update.select('svg')
  //   .attr('width', $('.wrap').width())
  //   .attr('height', $('.wrap').height());

  update.select('circle')
    .attr('r', function(d) { return d.r; });
    // .style('box-shadow','10px 10px 5px #888888;');

  update.select('text')
    .style('font-size', function(d) {return d.r / 3 + 'px';})
    .text(function(d) { return d.name + " ("+d.value+")"; })
    .style('opacity', 1);

  // EXIT
  var exit = node.exit()
    .transition()
    .remove()
  
  exit.select('circle').attr('r', 0);
  exit.select('text').style('opacity', 0);

}
}
});

