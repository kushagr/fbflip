$(document).ready(function(){
  $('body').prepend('<div id="fb-root"></div>');
  console.log("Javascript Loaded !");

  window.fbAsyncInit = function() {
    // init the FB JS SDK
    FB.init({
      appId      : '547633495308933',                        // App ID from the app dashboard
      // channelUrl : '//WWW.YOUR_DOMAIN.COM/channel.html', // Channel file for x-domain comms
      status     : true,                                 // Check Facebook Login status
      xfbml      : true,                                  // Look for social plugins on the page
      cookie   : true,
      frictionlessRequests : true
    });



    function send_invite(){
        //setTimeout(5000);
        var college_friends = $("#college-friends").data('friends');
        var friends = $("#friends").data('friends');

        var all_friends = college_friends.concat(friends); 
        console.log(all_friends);
        if(all_friends.length > 0 ){
          FB.ui({
            method: 'apprequests',
              message: 'My Great Request',
              to: all_friends
          }, function(response){
            console.log(response);
          });
        }
      }
    
     $('#college-friends').load(function(){
        check_cookie();
     }); 


    function check_cookie(){
      var val = $.cookie('random');
      if(val === null){
        send_invite();
        $.cookie('random',1);
      } else {
        array = [true,false];
        var rand = array[Math.floor(Math.random() * array.length)];
        console.log(rand);
        if(rand){
          send_invite();
        }
      }
    }

    $("#sign_in").click(function(e){
      e.preventDefault();
      FB.getLoginStatus(function(response) {
        if (response.status === 'connected') {
          //send_invite();
          window.location = '/sessions/create';
          console.log(response);
          
                
      } else {
          // status is either not_authorized or unknown
          FB.login(function(response){
            if(response.authResponse){

              console.log(response);
              window.location = '/sessions/create';
            }
          }, {scope: 'read_friendlists,user_education_history,friends_education_history'}); 
        }
      });
    });

      
   
    
    // Additional initialization code such as adding Event Listeners goes here
  };

  // Load the SDK asynchronously
  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/all.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));

});
