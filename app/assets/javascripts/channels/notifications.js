App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
   $('#friend-request-user').append(data.content);
   $('.incoming-friend-request').fadeIn(3000).fadeOut(6000);
   $('#friends').fadeTo('slow', 0.3, function(){
    $(this).css('background-color', 'red');
   }).fadeTo('slow', 1);
   $(this).fadeOut(1000).fadeIn(1000);
  }
});
