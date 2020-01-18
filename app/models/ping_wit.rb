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

puts response.code
puts response.body