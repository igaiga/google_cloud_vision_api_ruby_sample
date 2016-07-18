require 'net/https'
require 'json'

API_KEY = 'xxx'
API_URL = "https://vision.googleapis.com/v1/images:annotate?key=#{API_KEY}"

request_body = {
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

uri = URI.parse(API_URL)
https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true
request = Net::HTTP::Post.new(uri.request_uri)
request["Content-Type"] = "application/json"
response = https.request(request, request_body)

puts response.body
