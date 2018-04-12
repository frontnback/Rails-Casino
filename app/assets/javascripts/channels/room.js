var callCount = 0;

App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    if (data.not_turn == true) {
        console.log('hiding!');
        $('#poker-footer-wrap').css('visibility', 'hidden');
      } else if (data.turn == true) {
        console.log('revealing!');
        $('#poker-footer-wrap').css('visibility', 'visible');
      } else if (data.call == true) {
          $('#poker-footer-wrap').css('visibility', 'hidden');
          callCount += 1;
          if (callCount = 2) {
          $.ajax({
            url: "/flop"
          });
        }
      }
    }
});

//   $('#messages-table').append('<div class="message">' +
//     '<div class="message-user">' + data.username + ':' + '</div>' +
//     '<div class="message-user">' + data.content + '</div>');
// }