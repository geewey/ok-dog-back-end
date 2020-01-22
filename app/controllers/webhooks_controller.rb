class WebhooksController < ApplicationController
  # Incoming WebHooks don't come from this web application so will not have an
  # authentication token from this web application

  def webhook
    # webhook_envelope = JSON.parse(request.body.read)
    if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      # application/x-www-form-urlencoded
      data = params.as_json
    end

    # WebHook messages are sent in items.data.messages, see https://goo.gl/WT9DnH
    # Keys: "responseID", "queryResult", "originalDetectIntentRequest", "session"
    puts "****************"
    # puts data
    # puts "****************"
    intent = data["queryResult"]["intent"]["displayName"]
    puts intent
    # byebug
    puts "****************"


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

    # render json: webhook_envelope

    resp = { fulfillment_messages: ["weather WEATHER weather YAY."] }
    if intent == "weather"
      render json: resp.to_json()
    else
      Webhook::Received.save(data: data, integration: params[:integration_name])
      render nothing: true
    end
  end

end