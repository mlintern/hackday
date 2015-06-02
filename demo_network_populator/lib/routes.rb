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

get '/status/?' do
  erb :status
end

get '/status/check/?' do
  return 200, data.to_json
end

post '/go/?' do
  puts @request_payload
  admin = @request_payload["user"] || ""
  key = @request_payload[":key"] || ""

  data[:auth_user] = Nretnil::Password.uuid
  data[:network_id] = Nretnil::Password.uuid

  if populate(data)
    return 200, { :success => true }.to_json
  else
    return 200, { :success => false }.to_json
  end
end

post '/reset/?' do  
  if ( @request_payload["reset"].to_s.to_b )
    data = no_data
  end
  return 200, data.to_json
end

get '/template/?' do  
  return 200, default_template
end

get '/widget/categories/?' do  
  return 200, all_categories
end

get '/widget/last_couple/?' do  
  return 200, last_couple
end