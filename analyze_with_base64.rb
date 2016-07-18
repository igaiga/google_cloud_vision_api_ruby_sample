require 'net/https'
require 'base64'
require 'json'

API_KEY = 'xxx'
API_URL = "https://vision.googleapis.com/v1/images:annotate?key=#{API_KEY}"
IMAGE_FILE = './tokikake10.jpg'

base64_image = Base64.strict_encode64(File.new(IMAGE_FILE, 'rb').read)

request_body = {
  requests: [{
    image: {
      content: base64_image
    },
    features: [
      {
        type: 'LABEL_DETECTION',
        maxResults: 5
      }
    ]
  }]
}.to_json

uri = URI.parse(API_URL)
https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true
request = Net::HTTP::Post.new(uri.request_uri)
request["Content-Type"] = "application/json"
response = https.request(request, request_body)

puts response.body
