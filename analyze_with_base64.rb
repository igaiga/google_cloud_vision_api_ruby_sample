require 'net/https'
require 'json'
require 'base64'

# https://console.cloud.google.com/apis/credentials
API_KEY = 'xxx'

# https://vision.googleapis.com/v1/images:annotate?key=#{API_KEY}
API_URL = "https://vision.googleapis.com/v1/images:annotate"
uri = URI.parse(API_URL)
uri.query = "key=#{API_KEY}"

IMAGE_FILE = './tokikake10.jpg'
base64_image = File.open(IMAGE_FILE, 'rb') do |f|
  Base64.strict_encode64(f.read)
end

request = Net::HTTP::Post.new(uri.request_uri)
request.content_type = "application/json"
request.body = {
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

https_session = Net::HTTP.new(uri.host, uri.port)
https_session.use_ssl = true
response = https_session.start do |session|
  session.request(request)
end
puts response.body
