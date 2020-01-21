class WebhookController < ApplicationController
  # Incoming WebHooks don't come from this web application so will not have an
  # authentication token from this web application

  def weather_request
    webhook_envelope = JSON.parse(request.body.read)

    # WebHook messages are sent in items.data.messages, see https://goo.gl/WT9DnH
    puts webhook_envelope

    # if webhook_envelope["items"] && webhook_envelope["items"].kind_of?(Array)
    #   webhook_envelope["items"].each do |item|
    #     Array(item.dig('data', 'messages')).each do |message_raw|
    #       # Use Ably to decode messages from JSON so all decoding issues are handled by Ably
    #       message = Ably::Models::Message.from_json(message_raw)
    #       puts "Received Message with data '#{message.data}'"
    #     end
    #   end
    #   # Must respond with 20x response else the WebHook request will be retried
    #   render json: { "success": true }
    # else
    #   render json: { "error": "items Array attribute missing from body" },
    #          status: :unprocessable_entity
    # end
    render json: webhook_envelope.to_json()
  end

end