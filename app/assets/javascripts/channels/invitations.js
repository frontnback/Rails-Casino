App.invitations = App.cable.subscriptions.create("InvitationsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    if (data.inviter !== undefined) {
      $('#invite-username').append(data.inviter);
      $('.poker-invite').fadeIn();
    } else if (data.url !== undefined) {
      window.location.href = `localhost:3000${data.url}`
      console.log(data.url);
    }
  }
});
 