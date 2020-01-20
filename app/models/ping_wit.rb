### Using Wit Ruby client
# require 'wit'

# client = Wit.new(access_token: ENV["WIT_API_TOKEN"])
# rsp = client.message('hello!')

# puts(rsp)


require 'net/http'
require 'uri'

# Get a user input, CLI style
# https://stackoverflow.com/questions/2889720/one-liner-in-ruby-for-displaying-a-prompt-getting-input-and-assigning-to-a-var
def prompt(*args)
    print(*args)
    gets
end

user_input = prompt "Input message: "


uri = URI.parse("https://api.wit.ai/message?v=20170307&q=#{user_input}")
request = Net::HTTP::Get.new(uri)
request["Authorization"] = "Bearer #{ENV["WIT_API_TOKEN"]}"

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

# response.code
# response.body
entities = response.body["entities"]

console.log(entities)

# return_highest_confidence 

# if (response.code === 200) {
#     return_highest_confidence(entities)
# }

# {
#     "_text":"Hi there!",
#     "entities":
#         {
#             "search_query":
#                 [
#                     {
#                         "suggested":true,
#                         "confidence":0.88343,
#                         "value":"Hi",
#                         "type":"value"
#                     },
#                     {
#                         "suggested":true,
#                         "confidence":0.85634,
#                         "value":"!",
#                         "type":"value"
#                     }
#                 ],
#             "math_expression":
#                 [
#                     {
#                         "suggested":true,
#                         "confidence":0.92366,
#                         "value":"there",
#                         "type":"value"
#                     }
#                 ],
#             "greetings":
#                 [
#                     {
#                         "confidence":0.99992036819304,
#                         "value":"true"
#                     }
#                 ]
#         },
#     "msg_id":"1nKN6xS2q4eueqADx"
# }