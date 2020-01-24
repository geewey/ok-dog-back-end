class ApplicationController < ActionController::API

  require 'news-api'
  require 'open-uri'
  require "google/cloud/dialogflow"
  # require 'wit'

  ### Snippet for parsing queries when passing params

  def dialogflow
    query = params[:query]
    project_id = "ok-dog-sfhrlg"
    session_id = "123456789"
    language_code = "en-US"

    session_client = Google::Cloud::Dialogflow::Sessions.new
    session = session_client.class.session_path project_id, session_id
    
    query_input = { text: { text: query, language_code: language_code } }
    
    response = session_client.detect_intent session, query_input
    
    # returns JSON object
    query_result = response.query_result

    default_response = "Sorry! That's beyond me. Try asking me the news, weather, or a joke!"

    query_result.fulfillment_text == "" ? text_to_post = { "fulfillmentText": default_response } : text_to_post = { "fulfillmentText": query_result.fulfillment_text }

    puts text_to_post
    render json: text_to_post
  end

  # def yelp
    # yelp = ENV["YELP_API_KEY"]

    # query = params[:query].gsub('"', '')
    # location = query.split('_')[0]
    # category = query.split('_')[1]
    # yelp_url = "https://cors-anywhere.herokuapp.com/https://api.yelp.com/v3/businesses/search?term=#{category}&location=#{location}"
    # res = HTTParty.get(yelp_url, :headers => {"Authorization" => "Bearer #{yelp}", "x-requested-with" => "XMLHttpRequest"})
    # render plain: res.body.squish
  # end

  def wit
    # fetch from API
    Wit.init
    # resp = Wit.text_query('Hello!', ENV["WIT_API_TOKEN"] <-- error, temp solution is to hardcode)
    # p "Response: " + resp
    Wit.close
    # render json: render_to_page.to_json()
    render json: resp.to_json()
  end

  def error
    error_response = {error: "Sorry, I don't understand. Please try again."}
    render json: error_response
  end

  def news
    news_api_key = ENV["NEWS_API_KEY"]
    
    n = News.new(news_api_key)
    bbc_news_top_headlines = n.get_top_headlines(sources: "bbc-news")
    random_bbc_news_headline = bbc_news_top_headlines.sample
    render json: random_bbc_news_headline.to_json()
  end

  def joke
    # returns JSON object
    url = 'https://icanhazdadjoke.com/'
    req = open(url, {'Accept' => 'application/json','User-Agent' => 'Flatiron Student Project (https://github.com/geewey/)' })
    response_body = req.read
    json_response_body = JSON(response_body)
    joke_json_response_body = json_response_body.select{ |k, v| k == "joke" }
    # joke = JSON(response_body)["joke"]
    # render json: joke.to_json()
    render json: joke_json_response_body
  end

  def weather
    # returns JSON object
    weather_api_key = ENV["WEATHER_API_KEY"]

    url = 'api.openweathermap.org'
    city_name = 'London'
    country_code = 'uk'
    req = open("http://api.openweathermap.org/data/2.5/weather?q=
      #{city_name},#{country_code}&APPID=#{weather_api_key}")
    response_body = req.read
    render json: response_body
  end

end
