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
      default_city = 'london'
      puts "***********"
      puts "city input is nil?"
      puts data["queryResult"]["parameters"]["address"]["city"] == nil
      puts "***********"
      puts "default city: #{default_city}"
      puts "default city matches city input?"
      puts default_city == data["queryResult"]["parameters"]["address"]["city"].to_s.downcase
      puts "***********"
      if data["queryResult"]["parameters"]["address"]["city"] == nil
        city = default_city
      else 
        city = data["queryResult"]["parameters"]["address"]["city"].to_s
      end

      default_country_code = 'uk'
      
      req = JSON.parse(open("http://api.openweathermap.org/data/2.5/weather?q=
      #{city}&APPID=#{weather_api_key}").string)
      
      temp_kelvin = req["main"]["temp"]
      temp_celsius = (temp_kelvin - 273.15).round(1).to_s
      weather_description = req["weather"][0]["description"]
      city = city.split.map(&:capitalize).join(' ')
      
      # debugger
      weather_resp = { "fulfillmentText": "The weather in #{city} is currently #{temp_celsius} degrees Celsius, with #{weather_description} expected."}
      puts weather_resp
      render json: weather_resp.to_json()
    else
      render json: default_response
    end
  end

end