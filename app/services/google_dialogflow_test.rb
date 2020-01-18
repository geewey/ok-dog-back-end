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