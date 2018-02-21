jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  chart = Chartkick.charts["messages-chart"]
  if $('#messages').length > 0
    messages_to_bottom = ->
      messages.scrollTop(messages.prop("scrollHeight"))
      $(document).scrollTop(messages.prop("scrollHeight"))

    update_message_chart =->
      console.log(chart.getDataSource())
      #chart.updateData(chart.getDataSource())
      chart.refreshData()
      chart.redraw()


    messages_to_bottom()

    App.global_chat = App.cable.subscriptions.create {
      channel: "ChatRoomsChannel"
      chat_room_id: messages.data('chat-room-id')
    },
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        messages.append data['message']
        update_message_chart()
        messages_to_bottom()

      send_message: (message, chat_room_id) ->
        @perform 'send_message', message: message, chat_room_id: chat_room_id

    $('#new_message').submit (e) ->
      console.log(messages.data('chat-room-id'))
      $this = $(this)
      textarea = $this.find('#message_body')
      if $.trim(textarea.val()).length > 1
        App.global_chat.send_message textarea.val(), messages.data('chat-room-id')
        textarea.val('')
      e.preventDefault()
      return false