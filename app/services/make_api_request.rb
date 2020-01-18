# For future refactoring

# News API Ruby client library
require 'news-api'

# Net::HTTP wrapper
require 'open-uri'

# access secure API key
require 'dotenv'
Dotenv.load('.env')


news_api_key = ENV['NEWS_API_KEY']

# OPTION 1
n = News.new(news_api_key)

# Sources
return n.get_sources(country: 'us', language: 'en')

# All named sources available (GET)
# https://newsapi.org/v2/sources?apiKey=eca4f099393f4afcabd435e465c817fd

# All named sources with English news (GET)
# https://newsapi.org/v2/sources?language=en&apiKey=eca4f099393f4afcabd435e465c817fd

# All named sources with English news in the US (GET)
# https://newsapi.org/v2/sources?language=en&country=us&apiKey=eca4f099393f4afcabd435e465c817fd

# Everything
# n.get_everything(q: "apple", from: "2018-01-05&to=2018-01-05", sortBy: "popularity")

# Top Headlines
# n.get_top_headlines(sources: "bbc-news")


# OPTION 2
# require 'open-uri'
# url = 'https://newsapi.org/v2/top-headlines?'\
#       'country=us&'\
#       "apiKey=#{news_api_key}"
# req = open(url)
# response_body = req.read
# puts response_body
