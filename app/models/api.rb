require 'news-api'

class Api < ApplicationRecord
    has_many :api_commands
    has_many :commands, through: :api_commands
    


    def fetch_news
        # JSON.parse(RestClient.get(""))
        apiKey = ENV['NEWS_API_KEY']
        n = News.new(api_key)
        
        return n.get_top_headlines(sources: "bbc-news")

        # url = 'https://newsapi.org/v2/top-headlines?'\
        # 'country=us&'\
        # "apiKey=#{apiKey}"
        # # req = open(url)
        # req = JSON.parse(RestClient.get(url))
        # # response_body = req.read
        # return req
    end

end
