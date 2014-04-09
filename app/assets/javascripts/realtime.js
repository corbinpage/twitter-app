// $(".application.realtime").ready(function(){
//   if($("body").hasClass('realtime')) {
//     setTimeout(getNewTweets,1000);  
    
//     function getNewTweets(){
//       after = $( "#tweet_list li:last-child").attr("data-id");
//       if(! after) {
//         after = 1
//       };
//       console.log(after)
//       $.getJSON("update.json?after=" + after, function(data){
//           console.log(data)
//           if(data['id'] != -1) { // Skip an update if no new tweet has come in
//             updateViews(data);
//           }
//       });
//       setTimeout(getNewTweets,1000);  
//     }
//     function updateViews(data){
//       $("#tweet_list").append("<li data-id=" + data['id'] + ">" + data['id']+ ": Feeling " + data['sentiment_summary'] + " - " +data['text'] + "</li>")
//     }
//   }
// });
