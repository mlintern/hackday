class String
  def to_b
    return true if self.downcase == "true"
    return false if self.downcase == "false"
    return nil
  end
end

def auth_test(data)
  content_types = data[:auth_user].content_type.list
  if !content_types.key?(:error) && content_types.length > 0
    return true
  else
    return false
  end
end

def set_max(data,params)

  data[:users][:max] = params["UserCount"].to_i || 100
  data[:business_units][:max] = params["BUCount"].to_i || 50
  data[:categories][:max] = params["CategoryCount"].to_i || 50
  data[:publishers][:max] = params["PublisherCount"].to_i || 10
  data[:content][:max] = params["ContentCount"].to_i || 1000
  data[:languages][:max] = params["LanguageCount"].to_i || 10
  data[:content_types][:max] = 2
  data[:content_types][:max] += 1 if params["ImagePost"] == "on"
  data[:content_types][:max] += 1 if params["VideoPost"] == "on"
  data[:content_types][:max] += 1 if params["FilePost"] == "on"
  data[:projects][:max] = params["ProjectCount"].to_i || 20

  data
end

def get_current_data(data)

  # Get all of the current data and set the counts.\

  # get networks publishers
  pubs = data[:auth_user].publisher.list
  pubs.each do |pub|
    data[:publishers][:items] << { :name => pub["publisher_name"], :id => pub["id"] }
    data[:publishers][:count] += 1
  end 

  # get networks bus
  bus = data[:auth_user].bu.list
  bus.each do |bu|
    data[:business_units][:items] << { :name => bu["name"], :id => bu["business_unit_id"] }
    data[:business_units][:count] += 1
  end 

  # get networks users
  users = data[:auth_user].user.list
  users.each do |user|
    user["roles"].each do |role|
      if role["name"] == "Author"
        data[:users][:items] << { :name => user["firstname"] + " " + user["lastname"], :id => user["user_id"] }
        data[:users][:count] += 1
      end
    end
  end 

  # get networks categories
  categories = data[:auth_user].category.list({:NetworkId => data[:network_id], :SearchCriteria => { :BlogType => "category" }.to_json } )
  categories["Success"].each do |category|
    data[:categories][:items] << { :name => category["Title"], :id => category["BlogId"] }
    data[:categories][:count] += 1
  end

  # get networks content_types
  content_types = data[:auth_user].content_type.list
  content_types.each do |content_type|
    if content_type["landing_page"]
      type = "page"
    else
      type = content_type["primary_editor"]
    end
    data[:content_types][:items] << { :name => content_type["name"], :id => content_type["id"], :type => type }
    data[:content_types][:count] += 1
  end

  # get networks projects
  projects = data[:auth_user].project.list
  projects.each do |project|
    data[:projects][:items] << { :name => project["name"], :id => project["id"] }
    data[:projects][:count] += 1
  end

  # get networks languages
  languages = data[:auth_user].language.list
  languages.each do |language|
    data[:languages][:items] << { :name => language["name"], :id => language["id"] }
    data[:languages][:count] += 1
  end

  # get networks content
  content = data[:auth_user].content.list({:NetworkId => data[:network_id]})
  content["content"].each do |content|
    data[:content][:items] << { :name => content["title"], :id => content["id"] }
    data[:content][:count] += 1
  end

  data
end

def add_user(data)
  bu_ids = []
  data[:business_units][:items].each do |bu|
      bu_ids << bu["id"]
  end
  firstname = Nretnil::FakeData.name
  lastname = Nretnil::FakeData.surname
  username = (firstname[0,1] + lastname).downcase
  email = firstname+"."+lastname+"@"+Nretnil::FakeData.word+".com"
  user = data[:auth_user].user.add(username,firstname,lastname,email)
  user_id = user["Success"]["UserId"]
  result = data[:auth_user].role.assign(user_id,[data[:author_role_id]])
  data[:users][:items] << { :name => firstname + " " + lastname, :id => user_id }
  data[:users][:count] += 1
  data
end

def add_bu(data)
  pub_ids = []
  data[:publishers][:items].each do |pub|
      pub_ids << pub["id"]
  end
  name = Nretnil::FakeData.words(2)
  bu = data[:auth_user].bu.add(name,pub_ids)
  data[:business_units][:items] << { :name => name, :id => bu["business_unit_id"] }
  data[:business_units][:count] += 1
  data
end

def add_category(data)
  name = Nretnil::FakeData.word
  category = data[:auth_user].category.add(name,"category")
  data[:categories][:items] << { :name => name, :id => category["Success"] }
  data[:categories][:count] += 1
  data
end

def add_publisher(data)
  name = Nretnil::FakeData.word
  pub = data[:auth_user].publisher.add(name,name + ".compendiumblog.com", { :postsPerPage => 20, :start_page_ui_type => "uber" })
  data[:publishers][:items] << { :name => name, :id => pub["id"] }
  data[:publishers][:count] += 1
  data
end

def add_content(data)
  puts content_type = data[:content_types][:items][rand(data[:content_types][:count])]
  puts business_unit = data[:business_units][:items][rand(data[:business_units][:count])]
  puts publisher = data[:publishers][:items][rand(data[:publishers][:count])]
  puts user = data[:users][:items][rand(data[:users][:count])]
  puts categories = [ data[:categories][:items][rand(data[:categories][:count])][:id], data[:categories][:items][rand(data[:categories][:count])][:id] ]
  puts title = Nretnil::FakeData.words( rand(4) + 1 )
  puts slug = data[:auth_user].helper.slugify(title)
  puts pub_date = Time.now
  body = '<img  style="width: 30%; height: auto; float: left;" src="' + images[rand(images.count)] + '"/><p>' + paragraph + '</p><p>' + paragraph + '</p><p>' + paragraph + '</p><p>' + paragraph + '</p><img  style="width: 30%; height: auto; float: right;" src="' + images[rand(images.count)] + '"/><p>' + paragraph + '</p><p>' + paragraph + '</p><p>' + paragraph + '</p><p>' + paragraph + '</p>'
  options = { :business_unit_id => business_unit[:id], :publish_date => pub_date, :url_lookup_token => slug, :category_ids => categories, :publisher_id => publisher[:id] }
  case content_type[:type]
  when "image", "file"
    body = '<p>' + paragraph + '</p>'
    options = { :primary_attachment => { :url => images[rand(images.count)] }, :business_unit_id => business_unit[:id], :publish_date => pub_date, :url_lookup_token => slug, :category_ids => categories, :publisher_id => publisher[:id] }
  when "video"
    body = '<p>' + paragraph + '</p>'
    options = { :primary_attachment => { :url => videos[rand(videos.count)] }, :business_unit_id => business_unit[:id], :publish_date => pub_date, :url_lookup_token => slug, :category_ids => categories, :publisher_id => publisher[:id] }
  else
  end
  puts body
  puts options
  asset = data[:auth_user].content.add(user[:id], title, body, content_type[:id], options)
  data[:content][:items] << { :name => title, :id => asset["id"] }
  data[:content][:count] += 1
  data
end

def add_project(data)
  name = Nretnil::FakeData.word
  color = Nretnil::FakeData.color[:hex]
  project = data[:auth_user].project.add(name,{ :color => color })
  data[:projects][:items] << { :name => name, :id => project[:id] }
  data[:projects][:count] += 1
  data
end

def add_template (data)

  templates = data[:auth_user].get("/api/templates", { :network_id => data[:network_id] } )
  unless templates.count > 0
    result = data[:auth_user].post("/api/templates", { :network => "dbd66dde-eb86-4842-b522-7999c98f18ce", :name => "Network Populator Template" }.to_json )
    template_id = result["id"]


    result = data[:auth_user].post("/api/templates/"+template_id+"/template_files", { :name => "default.tpl" }.to_json )
    default_id = result["id"]

    result = data[:auth_user].put("/api/template_files/"+default_id, { :content => default_template }.to_json )

    result = data[:auth_user].post("/api/templates/"+template_id+"/widgets", { :widget_type => "AllCategories", :widget_name => "Categories" }.to_json )
    categories_id = result["template_file"]["id"]
    result = data[:auth_user].put("/api/template_files/"+categories_id, { :content => all_categories }.to_json )

    result = data[:auth_user].post("/api/templates/"+template_id+"/widgets", { :widget_type => "ContentList", :widget_name => "Last Couple", :properties => { :limit => 2 } }.to_json )
    last_couple_id = result["template_file"]["id"]
    result = data[:auth_user].put("/api/template_files/"+last_couple_id, { :content => last_couple }.to_json )

    result = data[:auth_user].post("/api/templates/"+template_id+"/revisions", { :comment => "publishing" }.to_json )
  end

end

def populate(data)

  add_template( data )


  (data[:publishers][:count]...data[:publishers][:max]).each do |i|
    data = add_publisher(data)
  end

  (data[:business_units][:count]...data[:business_units][:max]).each do |i|
    data = add_bu(data)
  end

  roles = data[:auth_user].role.list
  roles.each do |role|
    if role["name"] == "Author"
      data[:author_role_id] = role["id"]
    end
  end

  (data[:users][:count]...data[:users][:max]).each do |i|
    data = add_user(data)
  end

  (data[:categories][:count]...data[:categories][:max]).each do |i|
    data = add_category(data)
  end

  page_type = text_type = image_type = file_type = video_type = false

  data[:content_types][:items].each do |ct|
    case ct[:type]
      when "rich_text"
        text_type = true
      when "page"
        page_type = true
      when "video"
        video_type = true
      when "image"
        image_type = true
      when "file"
        file_type = true
      else
      end
  end

  if !text_type
    ct = data[:auth_user].content_type.add("Text NP", { :primary_editor => "rich_text", :config => { :show_description => true } } )
    data[:content_types][:items] << { :name => "Text NP", :id => ct["id"], :type => "rich_text" }
    data[:content_types][:count] += 1
  end

  if !page_type
    ct = data[:auth_user].content_type.add("Page NP", { :primary_editor => "rich_text", :config => { :show_description => true }, :landing_page => true } )
    data[:content_types][:items] << { :name => "Page NP", :id => ct["id"], :type => "page" }
    data[:content_types][:count] += 1
  end

  if data[:params]["ImagePost"] == "on" && !image_type
    ct = data[:auth_user].content_type.add("Image NP", { :primary_editor => "image", :config => { :show_description => true } } )
    data[:content_types][:items] << { :name => "Image NP", :id => ct["id"], :type => "image" }
    data[:content_types][:count] += 1
  end

  if data[:params]["VideoPost"] == "on" && !video_type
    ct = data[:auth_user].content_type.add("Video NP", { :primary_editor => "video", :config => { :show_description => true } } )
    data[:content_types][:items] << { :name => "Video NP", :id => ct["id"], :type => "video" }
    data[:content_types][:count] += 1
  end

  if data[:params]["FilePost"] == "on" && !file_type
    ct = data[:auth_user].content_type.add("File NP", { :primary_editor => "file", :config => { :show_description => true } } )
    data[:content_types][:items] << { :name => "File NP", :id => ct["id"], :type => "file" }
    data[:content_types][:count] += 1
  end

  (data[:projects][:count]...data[:projects][:max]).each do |i|
    data = add_project(data)
  end

  (data[:languages][:count]...data[:languages][:max]).each do |i|
    lang = data[:auth_user].language.add(languages[i][:name],languages[i][:code])
    data[:languages][:items] << { :name => languages[i][:name], :id => lang["id"] }
    data[:languages][:count] += 1
  end

  (data[:content][:count]...data[:content][:max]).each do |i|
    data = add_content(data)
  end

  return true
end


