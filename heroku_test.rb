
project_id = "ok-dog-sfhrlg"
session_id = "123456789"
texts = ["hello"]
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