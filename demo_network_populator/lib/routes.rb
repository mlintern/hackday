data = nil
the_params = nil

before do
  # puts session.inspect
  if request.body.size > 0
    request.body.rewind
    @request_payload = JSON.parse request.body.read
  end
end

get '/' do
  erb :index, :locals => { :params => the_params || {} }
end

get '/status/?' do
  erb :status
end

get '/status/check/?' do
  return 200, data.to_json
end

post '/go/?' do
  puts @request_payload

  data = session[:data] = default_data

  the_params = data[:params] = @request_payload

  data = session[:data] = set_max(data,@request_payload)

  admin = @request_payload["UserName"]
  key = @request_payload["UserKey"]
  server = "https://dev.cpdm.oraclecorp.com/"

  data[:auth_user] = Nretnil::CompendiumAPI::Compendium.new(admin, key, server)

  if !ENV['ROOT_USERNAME'].nil? && !ENV['ROOT_KEY'].nil?
    puts "Creating Root User"
    data[:root_user] = Nretnil::CompendiumAPI::Compendium.new(ENV['ROOT_USERNAME'], ENV['ROOT_KEY'], server)
  end

  if auth_test(data)
    
    data[:network_id] = data[:auth_user].helper.network_id

    data = session[:data] = get_current_data(data)

    if populate(data)
      data[:all_done] = true
      return 200, { :success => true }.to_json
    else
      data[:all_done] = true
      return 200, { :success => false }.to_json
    end
  else
    data = session[:data] = false
    return 400, { :error => "Bad Credentials" }.to_json
  end
end

get "/error" do
  erb :error
end