data = default_data

before do
  if request.body.size > 0
    request.body.rewind
    @request_payload = JSON.parse request.body.read
  end
end

get '/' do
  erb :index 
end

get '/status' do
  return 200, data.to_json
end

post '/go' do
  admin = @request_payload["user"] || ""
  key = @request_payload[":key"] || ""

  data[:auth_user] = Nretnil::Password.uuid
  data[:network_id] = Nretnil::Password.uuid

  data = populate(data)

  return 200, data.to_json
end

post '/reset' do  
  if ( @request_payload["reset"].to_s.to_b )
    data = no_data
  end
  return 200, data.to_json
end