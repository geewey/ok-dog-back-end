class ApplicationController < ActionController::API

    require 'news-api'
    require 'open-uri'

    # Snippet for parsing queries when passing params

    # query = params[:query].gsub('"', '')
    # location = query.split('_')[0]
    # category = query.split('_')[1]
    # news_url = "https://cors-anywhere.herokuapp.com/https://api.news.com/v3/businesses/search?term=#{category}&location=#{location}"
    # res = HTTParty.get(yelp_url, :headers => {"Authorization" => "Bearer #{yelp}", "x-requested-with" => "XMLHttpRequest"})
    # render plain: res.body.squish

    def news
        news_api_key = ENV["NEWS_API_KEY"]
        
        n = News.new(news_api_key)
        bbc_news_top_headlines = n.get_top_headlines(sources: "bbc-news")
        render json: bbc_news_top_headlines.to_json()

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
