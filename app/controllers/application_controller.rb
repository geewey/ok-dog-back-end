class ApplicationController < ActionController::API

    require 'news-api'
    require 'open-uri'
    # require "google/cloud/dialogflow"
    # require 'wit'

    
    def wit
        # fetch from API
        # q = encodeURIComponent('What is 2 + 2?');
        # uri = 'https://api.wit.ai/message?q=' + q;
        # auth = 'Bearer ' + ENV["WIT_API_TOKEN"];

        # fetch(uri, {headers: {Authorization: auth}})
        #     .then(res => res.json())
        # ERROR HERE
        #     .then(res => {render_to_page = res});
        
        Wit.init


        # resp = Wit.text_query('Hello!', ENV["WIT_API_TOKEN"])
        resp = Wit.text_query('Hello!', NEP4G6G73FDM7ZXN4QLSRZISSAPKMNO2)
        # p "Response: " + resp

        Wit.close

        # render json: render_to_page.to_json()
        render json: resp.to_json()
    end

    # def google_dialogflow
    #     dialogflow_project = ENV["DIALOGFLOW_PROJECT"]
    #     dialogflow_credentials = ENV["DIALOGFLOW_CREDENTIALS"]
        
    #     client = Google::Cloud::Dialogflow::Agents.new
        
    #     render json: dialogflow_project.to_json()
    # end


    def error
        error_response = {error: "Sorry, I don't understand. Please try again."}
        render json: error_response
    end

    ### Snippet for parsing queries when passing params

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
        first_bbc_news_headline = bbc_news_top_headlines[0]
        render json: first_bbc_news_headline.to_json()

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
