var SIZE = 800;
var DATA = {"name":"bevs","children":[
            {"name":"tea","size":74},
            {"name":"whiskey","size":5},
            {"name":"beer","size":54},
            {"name":"gatorade","size":1},
            {"name":"coffee","size":86},
            {"name":"fanta","size":6},
            {"name":"wine","size":38}
          ]};

var bubble = d3.layout.pack()
  .sort(null)
  .size([SIZE, SIZE])
  .padding(1.5)
  .value(function(d) {return d.size;});

var svg = d3.select('body')
  .append('svg')
  .attr('width', SIZE)
  .attr('height', SIZE);

var color = d3.scale.category10();

function update(data) { 
  
  var data = bubble.nodes(data).filter(function(d) {return !d.children;});

  var node = svg.selectAll(".node")
    .data(data, function(d) {return d.name; });
 
  // enter
  var enter = node.enter().append('g')
    .attr('class', 'node')
    .attr('transform', function(d) {return 'translate(' + d.x + ',' + d.y + ')';});
  
  enter.append('circle')
    .attr('r', 0)
    .style('fill', function(d) {return color(d.name);});

  enter.append('text')
    .style('opacity', 0)
    .style('fill', 'black')
    .style('text-anchor', 'middle')
    .text(function(d) {return d.name;});

  // enter.append('p')

  //update
  var update = node.transition()
    .attr('transform', function(d) {return 'translate(' + d.x + ',' + d.y + ')';});

  update.select('circle')
      .attr('r', function(d) { return d.r; })
  
  update.select('text')
      .style('opacity', 1)
      .style('font-size', function(d) {return d.r / 3 + 'px';})

  // exit
  var exit = node.exit().transition()

  exit.select('circle').attr('r', 0);
  
  exit.select('text').remove();
 }
 
 update(DATA);
 
 
 
 
 
 
 
 
 
setTimeout(function() {
  DATA.children[0].size = 100; // changes size of tea to 100
  update(DATA);
}, 1000);
 
setTimeout(function() {
  DATA.children.pop();    // removes wine from JSON
  update(DATA);
}, 2000);
 
setTimeout(function() {
  DATA.children.push({name: "espresso", size: 200});    // adds wine from JSON
  update(DATA);
}, 3000);