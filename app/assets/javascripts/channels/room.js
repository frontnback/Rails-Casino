App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    $('#messages-table').append('<div class="message">' +
      '<div class="message-user">' + data.username + ':' + '</div>' +
      '<div class="message-user">' + data.content + '</div>');
  }
});

// function scroll_bottom (){
//   let scrollHeight = $('#messages-table').height();
//   $('#messages').animate({ scrollTop: $("#messages").prop("scrollHeight") });
// }

// function submit_message() {
//   $('#message_content').on('keydown' function(event) {
//     if (event.keyCode === 13) {
//       event.target.value = ''
//       event.preventDefault();
//       console.log('submitted!');
//     }
//   })

// }->
//   $('#message_content').on 'keydown', (event) ->
//     if event.keyCode is 13
//       $('input').click()
//       event.target.value = ""
//       event.preventDefault()




// App.room = App.cable.subscriptions.create "RoomChannel",
//   connected: ->
//     # Called when the subscription is ready for use on the server

//   disconnected: ->
//     # Called when the subscription has been terminated by the server

//   received: (data) ->
//     $('.messages-table').append '<div class="message">' +
//         '<div class="message-user">' + data.username + ":" + '</div>' +
//         '<div class="message-content">' + data.content + '</div>' + '</div>'

// $(document).on 'turbolinks:load', ->
//   submit_message()

// submit_message = () ->
//   $('#message_content').on 'keydown', (event) ->
//     if event.keyCode is 13
//       console.log(event)
