App.invitations = App.cable.subscriptions.create("InvitationsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    if (data.invitation !== undefined) {
      console.log('running!!');
      $('#invite-username').append(data.inviter);
      let num = data.invitation.id;
      $('#invite-url').attr('href', function(i, href) {
        return href + num;
      });
      $('.poker-invite').fadeIn();
    } else if (data.url !== undefined) {
      window.location.href = `localhost:3000${data.url}`
      console.log(data.url);
    }
  }
});
 