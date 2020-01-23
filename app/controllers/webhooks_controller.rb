class WebhooksController < ApplicationController

  require 'open-uri'

  def webhook
    if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      # application/x-www-form-urlencoded
      data = params.as_json
    end
    
    # data (hash) has keys: ["responseID", "queryResult", "originalDetectIntentRequest", "session"]
    # queryResult (hash) has keys: ["queryText", "action", "parameters", "allRequiredParamsPresent", "fulfillmentMessages", "outputContexts", "intent", "intentDetectionConfidence", "languageCode"]
    # req, resp documentation here: https://cloud.google.com/dialogflow/docs/fulfillment-how
    
    # puts "****************"
    intent = data["queryResult"]["intent"]["displayName"]
    puts "--> intent: #{intent}"
    # puts "****************"

    # Default response
    default_response = { "fulfillmentText": "Sorry! That's beyond me. Try asking me the news, weather, or a joke!" }
    
    # Process the webhook
    if intent == "weather"
      puts "--> weather path"
      
      # test this line for async fetching
      # weather_resp = { "fulfillmentText": "good luck" }
      
      weather_api_key = ENV["WEATHER_API_KEY"]

      # url = 'api.openweathermap.org'
      inputted_city = data["queryResult"]["parameters"]["address"]["city"].downcase
      default_city = 'london'
      city = default_city == inputted_city ? default_city.titleize : inputted_city.titleize

      default_country_code = 'uk'
      req = JSON.parse(open("http://api.openweathermap.org/data/2.5/weather?q=
      #{city}&APPID=#{weather_api_key}").string)
      
      temp_kelvin = req["main"]["temp"]
      temp_celsius = (temp_kelvin - 273.15).round(1).to_s
      weather_description = req["weather"][0]["description"]

      # debugger
      weather_resp = { "fulfillmentText": "The weather in #{city} is currently #{temp_celsius} degrees Celsius, with #{weather_description} expected."}
      render json: weather_resp
    else
      render json: default_response
    end
  end

end