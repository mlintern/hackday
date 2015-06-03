before do
  if request.body.size > 0
    request.body.rewind
    @request_payload = JSON.parse request.body.read
  end
end

get '/' do
  erb :index, :locals => { :params => session[:params] || {} }
end

get '/status/?' do
  erb :status
end

get '/status/check/?' do
  return 200, session[:data].to_json
end

post '/go/?' do
  puts @request_payload
  session[:params] = @request_payload

  session[:data] = default_data

  session[:data] = set_max(session[:data],@request_payload)

  admin = @request_payload["UserName"]
  key = @request_payload["UserKey"]
  server = "https://dev.cpdm.oraclecorp.com"

  session[:data][:auth_user] = Nretnil::CompendiumAPI::Compendium.new(admin, key, server)

  if auth_test(session[:data])
    
    session[:data][:network_id] = session[:data][:auth_user].helper.network_id

    session[:data] = get_current_data(session[:data])

    if populate(session[:data])
      return 200, { :success => true }.to_json
    else
      return 200, { :success => false }.to_json
    end
  else
    session[:data] = false
    return 400, { :error => "Bad Credentials" }.to_json
  end
end

get "/error" do
  erb :error
end