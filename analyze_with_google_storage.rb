require 'net/https'
require 'json'

# https://console.cloud.google.com/apis/credentials
API_KEY = 'xxx'

# https://vision.googleapis.com/v1/images:annotate?key=#{API_KEY}
API_URL = "https://vision.googleapis.com/v1/images:annotate"
uri = URI.parse(API_URL)
uri.query = "key=#{API_KEY}"

request = Net::HTTP::Post.new(uri.request_uri)
request.content_type = "application/json"
request.body = {
 "requests": [
  {
   "features": [
    {
     "type": "LABEL_DETECTION"
    }
   ],
   "image": {
    "source": {
     "gcsImageUri": "gs://igatest/demo-image.jpg"
    }
   }
  }
 ]
}.to_json

https_session = Net::HTTP.new(uri.host, uri.port)
https_session.use_ssl = true
response = https_session.start do |session|
  session.request(request)
end
puts response.body
