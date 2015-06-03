data = {}
the_params = {}

before do
  if request.body.size > 0
    request.body.rewind
    @request_payload = JSON.parse request.body.read
  end
end

get '/' do
  erb :index, :locals => { :params => the_params }
end

get '/status/?' do
  erb :status
end

get '/status/check/?' do
  return 200, data.to_json
end

post '/go/?' do
  puts @request_payload
  the_params = @request_payload

  data = default_data

  data = set_max(data,@request_payload)

  admin = @request_payload["UserName"]
  key = @request_payload["UserKey"]
  server = "https://dev.cpdm.oraclecorp.com"

  data[:auth_user] = Nretnil::CompendiumAPI::Compendium.new(admin, key, server)

  if auth_test(data)
    
    data[:network_id] = data[:auth_user].helper.network_id

    data = get_current_data(data)

    if populate(data)
      return 200, { :success => true }.to_json
      the_params = {}
    else
      return 200, { :success => false }.to_json
    end
  else
    data = false
    return 400, { :error => "Bad Credentials" }.to_json
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

get "/error" do
  erb :error
end