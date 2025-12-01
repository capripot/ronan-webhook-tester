# frozen_string_literal: true

require "sinatra"
require "json"

PERMITTED_HOSTS = ["ronan-webhook-tester.test", "ronan-webhook-tester.loca.lt"]

set :port, 8081
set :host_authorization, { permitted_hosts: PERMITTED_HOSTS }

puts "Permitted hosts: #{PERMITTED_HOSTS}"

log_body = lambda do
  request.body.rewind
  body = request.body.read
  payload = JSON.parse(body)

  puts JSON.pretty_generate(payload)

  "JSON body request received, thanks!"
rescue JSON::ParserError
  puts body
  "Request received, thanks!" 
rescue => e
  status 500
end

get "/", &log_body
post "/", &log_body
