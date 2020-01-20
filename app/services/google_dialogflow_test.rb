###
### To use an API, include the corresponding generated file and instantiate the service. ###
###

### For example to use the Drive API:
# https://github.com/googleapis/google-api-ruby-client/blob/master/docs/getting-started.md

# require 'google/apis/drive_v2'

# Drive = Google::Apis::DriveV2 # Alias the module
# drive = Drive::DriveService.new
# drive.authorization = ... # See Googleauth or Signet libraries

# # Search for files in Drive (first page only)
# files = drive.list_files(q: "title contains 'finances'")
# files.items.each do |file|
#   puts file.title
# end

# # Upload a file
# metadata = Drive::File.new(title: 'My document')
# metadata = drive.insert_file(metadata, upload_source: 'test.txt', content_type: 'text/plain')

# # Download a file
# drive.get_file(metadata.id, download_dest: '/tmp/myfile.txt')


### An example to use the Content API (Google Merchant Center)

# require 'google/apis/content_v2'
# require 'googleauth' # https://github.com/googleapis/google-auth-library-ruby

# Content = Google::Apis::ContentV2 # Alias the module
# content = Content::ShoppingContentService.new

# scope = 'https://www.googleapis.com/auth/content'
# merchant_id = # Merchant ID found on dashboard

# content.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
#   json_key_io: File.open('./content-api-key.json'),
#   scope: scope)

# content.authorization.fetch_access_token!
# # Service methods: https://googleapis.dev/ruby/google-api-client/latest/Google/Apis/ContentV2/ShoppingContentService.html
# content.list_datafeeds(merchant_id) # Returns Google::Apis::ContentV2::ListDatafeedsResponse

###
### Authorization using API keys
###

### Some APIs allow using an API key instead of OAuth2 tokens. For these APIs, set the key attribute of the service instance. For example:

# require 'google/apis/translate_v2'

# translate = Google::Apis::TranslateV2::TranslateService.new
# translate.key = 'YOUR_API_KEY_HERE'
# result = translate.list_translations('Hello world!', 'es', source: 'en')
# puts result.translations.first.translated_text

### 
### Authorization using environment variables
### 

### The GoogleAuth Library for Ruby also supports authorization via environment variables if you do not want to check in developer credentials or private keys. Simply set the following variables for your application:

# GOOGLE_ACCOUNT_TYPE="YOUR ACCOUNT TYPE" # ie. 'service'
# GOOGLE_CLIENT_EMAIL="YOUR GOOGLE DEVELOPER EMAIL"
# GOOGLE_PRIVATE_KEY="YOUR GOOGLE DEVELOPER API KEY"


require 'google/apis/dialogflow_v2'

dialog_flow = Google::Apis::Dialogflow_V2::Dialogflow.new
dialog_flow.key = ENV['']

### SAMPLE BELOW ###
project_id = "ok-dog-sfhrlg"
session_id = "123456789"
texts = ["hello", "what is the weather?", "what is the time right now?", "goodbye"]
language_code = "en-US"

require "google/cloud/dialogflow"

session_client = Google::Cloud::Dialogflow::Sessions.new
session = session_client.class.session_path project_id, session_id
puts "Session path: #{session}"

texts.each do |text|
  query_input = { text: { text: text, language_code: language_code } }
  response = session_client.detect_intent session, query_input
  query_result = response.query_result

  puts "Query text:        #{query_result.query_text}"
  puts "Intent detected:   #{query_result.intent.display_name}"
  puts "Intent confidence: #{query_result.intent_detection_confidence}"
  puts "Fulfillment text:  #{query_result.fulfillment_text}\n"
end