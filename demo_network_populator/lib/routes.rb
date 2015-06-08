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
  # server = "https://dev.cpdm.oraclecorp.com/"
  server = "https://app.test-cpdm.oraclecorp.com"

  data[:auth_user] = Nretnil::CompendiumAPI::Compendium.new(admin, key, server)

  if !ENV['ROOT_USERNAME'].nil? && !ENV['ROOT_KEY'].nil?
    puts "Creating Root User"
    data[:root_user] = Nretnil::CompendiumAPI::Compendium.new(ENV['ROOT_USERNAME'], ENV['ROOT_KEY'], server)
  end

  if auth_test(data)
    
    data[:network_id] = data[:auth_user].helper.network_id

    unless data[:root_user].nil?
      puts data[:root_user].post('/app/network/edit/json', { :NetworkId => data[:network_id], :Attributes => { :BuLimit => 100 }.to_json } )
      features = { :et_data_extensions => { :description => "Enable ExactTarget Data Extensions", :enabled => false }, :web_spellchecker => { :description => "Web Spellchecker", :enabled => false }, :sales_demo => { :description => "Fake Analytics for Sales Demo Account", :enabled => false }, :show_fake_social_data => { :description => "Fake Social Promotions for Sales Demo Account", :enabled => false }, :w2p_received_story => { :description => "We Received Your Story W2P Email", :enabled => false }, :allow_sticky_post => { :description => "Enable Make Post Sticky Option", :enabled => false }, :persona_wizard => { :description => "Enable Persona Assignment Wizard", :enabled => false }, :sso_enabled => { :description => "Enable Single Sign On", :enabled => false }, :enable_auto_categories_page => { :description => "Enable the Automatic Categories Page", :enabled => false }, :wordpress_import => { :description => "Enable Wordpress Import", :enabled => false }, :multiple_languages => { :description => "Enable Multiple Languages on Network", :enabled => true }, :addvocate => { :description => "Enable Addvocate Integration", :enabled => false }, :gaggleamp => { :description => "Enable GaggleAMP Integration", :enabled => false }, :appinions => { :description => "Enable Appinions Integration", :enabled => false }, :manage_publishers => { :description => "Enable Publishers Management", :enabled => true } }
      puts data[:root_user].put('/api/features',{ :id => data[:network_id] }.merge(features).to_json )
    end

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