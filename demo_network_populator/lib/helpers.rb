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
  puts pubs = data[:auth_user].publisher.list
  pubs.each do |pub|
    data[:publishers][:items] << { :name => pub["publisher_name"], :id => pub["id"] }
    data[:publishers][:count] += 1
  end 

  # get networks bus
  puts bus = data[:auth_user].bu.list
  bus.each do |bu|
    data[:business_units][:items] << { :name => bu["name"], :id => bu["business_unit_id"] }
    data[:business_units][:count] += 1
  end 

  # get networks users
  puts users = data[:auth_user].user.list
  users.each do |user|
    user["roles"].each do |role|
      if role["name"] == "Author"
        data[:users][:items] << { :name => user["firstname"] + " " + user["lastname"], :id => user["user_id"] }
        data[:users][:count] += 1
      end
    end
  end 

  # get networks categories
  puts categories = data[:auth_user].category.list({:NetworkId => data[:network_id], :SearchCriteria => { :BlogType => "category" }.to_json } )
  categories["Success"].each do |category|
    data[:categories][:items] << { :name => category["Title"], :id => category["BlogId"] }
    data[:categories][:count] += 1
  end

  # get networks content_types
  puts content_types = data[:auth_user].content_type.list
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
  puts projects = data[:auth_user].project.list
  projects.each do |project|
    data[:projects][:items] << { :name => project["name"], :id => project["id"] }
    data[:projects][:count] += 1
  end

  # get networks languages
  puts languages = data[:auth_user].language.list
  languages.each do |language|
    data[:languages][:items] << { :name => language["name"], :id => language["id"] }
    data[:languages][:count] += 1
  end

  # get networks content
  puts content = data[:auth_user].content.list_all({:NetworkId => data[:network_id]})
  content["content"].each do |content|
    data[:content][:items] << { :name => content["title"], :id => content["id"] }
    data[:content][:count] += 1
  end

  data
end

def add_user(data)
  bu_ids = []
  data[:business_units][:items].each do |bu|
      bu_ids << bu[:id]
  end
  firstname = Nretnil::FakeData.name
  lastname = Nretnil::FakeData.surname
  username = (firstname[0,1] + lastname).downcase + "-" + data[:network_id]
  email = firstname+"."+lastname+"@"+Nretnil::FakeData.word+".com"
  puts user = data[:auth_user].user.add(username,firstname,lastname,email,{ :BusinessUnits => bu_ids })
  user_id = user["Success"]["UserId"]
  puts result = data[:auth_user].role.assign(user_id,[data[:author_role_id]])
  data[:users][:items] << { :name => firstname + " " + lastname, :id => user_id }
  data[:users][:count] += 1
  data
end

def add_bu(data)
  pub_ids = []
  data[:publishers][:items].each do |pub|
      pub_ids << pub[:id]
  end
  name = Nretnil::FakeData.words(2)
  puts bu = data[:auth_user].bu.add(name.capitalize,pub_ids)
  data[:business_units][:items] << { :name => name.capitalize, :id => bu["business_unit_id"] }
  data[:business_units][:count] += 1
  data
end

def add_category(data)
  name = categories[rand(categories.count)]
  puts category = data[:auth_user].category.add(name,"category")
  data[:categories][:items] << { :name => name.capitalize, :id => category["Success"] }
  data[:categories][:count] += 1
  data
end

def add_publisher(data)
  name = Nretnil::FakeData.word
  puts pub = data[:auth_user].publisher.add(name.capitalize,name + ".compendiumblog.com", { :postsPerPage => 10, :start_page_ui_type => "uber", :start_page_ui_id => "", :render_engine => "twig", :uri_pattern => "flex" })
  data[:publishers][:items] << { :name => name.capitalize, :id => pub["id"] }
  data[:publishers][:count] += 1
  data
end

def add_content(data)
  content_type = data[:content_types][:items][rand(data[:content_types][:count])]
  business_unit = data[:business_units][:items][rand(data[:business_units][:count])]
  publisher = data[:publishers][:items][rand(data[:publishers][:count])]
  user = data[:users][:items][rand(data[:users][:count])]
  project = data[:projects][:items][rand(data[:projects][:count])]
  categories = [ data[:categories][:items][rand(data[:categories][:count])][:id], data[:categories][:items][rand(data[:categories][:count])][:id] ]
  title = Nretnil::FakeData.words( rand(4) + 1 ).capitalize
  slug = data[:auth_user].helper.slugify(title)
  pub_date = Time.now
  body = '<img  style="width: 30%; height: auto; float: left; margin: 5px;" src="' + images[rand(images.count)] + '"/><p>' + paragraphs[rand(paragraphs.count)] + '</p><p>' + paragraphs[rand(paragraphs.count)] + '</p><p>' + paragraphs[rand(paragraphs.count)] + '</p><p>' + paragraphs[rand(paragraphs.count)] + '</p><img  style="width: 30%; height: auto; float: right; margin: 5px;" src="' + images[rand(images.count)] + '"/><p>' + paragraphs[rand(paragraphs.count)] + '</p><p>' + paragraphs[rand(paragraphs.count)] + '</p><p>' + paragraphs[rand(paragraphs.count)] + '</p><p>' + paragraphs[rand(paragraphs.count)] + '</p>'
  options = { :business_unit_id => business_unit[:id], :publish_date => pub_date, :url_lookup_token => slug, :category_ids => categories, :publisher_id => publisher[:id], :campaign_id => project[:id] }
  case content_type[:type]
  when "image"
    body = '<p>' + paragraphs[rand(paragraphs.count)] + '</p>'
    image = images[rand(images.count)]
    extra_options = { :primary_attachment => { :url => image }, :featured_image => image }
  when "video"
    body = '<p>' + paragraphs[rand(paragraphs.count)] + '</p>'
    image = images[rand(images.count)]
    video = videos[rand(videos.count)]
    extra_options = { :primary_attachment => { :url => video, :featured_image => image } }
  when "file"
    body = '<p>' + paragraphs[rand(paragraphs.count)] + '</p>'
    image = images[rand(images.count)]
    file = files[rand(files.count)]
    extra_options = { :primary_attachment => { :url => file }, :featured_image => image }
  else
    extra_options = {}
  end
  body
  options = options.merge(extra_options)
  if data[:root_user].nil?
    puts asset = data[:auth_user].content.add(user[:id], title, body, content_type[:id], options)
  else
    approval_options = { 
      :import_live => true,
      :import_from => "Network Populator",
      :network_id => data[:network_id],
      :publish_date => pub_date,
      :post_publication => {
        :remote_id => nil,
        :publish_stamp => pub_date,
        :remote_url => nil,
        :remote_state => nil,
        :state => 'published'
      }
    }
    options = options.merge(approval_options)
    puts asset = data[:root_user].content.add(user[:id], title, body, content_type[:id], options)
  end
  case content_type[:type]
  when "image"
    asset_id = asset["id"]
    file_name = image.split("/")[-1]
    puts attachment = data[:auth_user].post("/api/posts/"+asset_id+"/attachments", { :name => file_name, :source_url => image, :url => image, :type => "image/jpeg", :primary_content => true, :storage_location => "File" }.to_json )
  when "video"
    asset_id = asset["id"]
    file_name = "EmbeddedVideo"
    puts attachment = data[:auth_user].post("/api/posts/"+asset_id+"/attachments", { :name => file_name, :url => video, :type => "video", :primary_content => true, :storage_location => "Embed" }.to_json )
  when "file"
    asset_id = asset["id"]
    file_name = image.split("/")[-1]
    puts attachment = data[:auth_user].post("/api/posts/"+asset_id+"/attachments", { :name => file_name, :source_url => file, :url => file, :type => "image/jpeg", :primary_content => true, :storage_location => "File" }.to_json )
  else
  end
  data[:content][:items] << { :name => title, :id => asset["id"] }
  data[:content][:count] += 1
  data
end

def add_project(data)
  name = Nretnil::FakeData.word
  color = Nretnil::FakeData.color[:hex]
  project = data[:auth_user].project.add(name.capitalize,{ :color => color })
  data[:projects][:items] << { :name => name.capitalize, :id => project[:id] }
  data[:projects][:count] += 1
  data
end

def add_template (data)

  templates = data[:auth_user].get("/api/templates", { :network_id => data[:network_id] } )
  unless templates.count > 0
    puts result = data[:auth_user].post("/api/templates", { :network => data[:network_id], :name => "Network Populator Template" }.to_json )
    template_id = result["id"]

    puts result = data[:auth_user].post("/api/templates/"+template_id+"/template_files", { :name => "default.tpl" }.to_json )
    default_id = result["id"]

    puts result = data[:auth_user].put("/api/template_files/"+default_id, { :content => default_template }.to_json )

    puts result = data[:auth_user].post("/api/templates/"+template_id+"/widgets", { :widget_type => "AllCategories", :widget_name => "Categories" }.to_json )
    categories_id = result["template_file"]["id"]
    puts result = data[:auth_user].put("/api/template_files/"+categories_id, { :content => all_categories }.to_json )

    puts result = data[:auth_user].post("/api/templates/"+template_id+"/widgets", { :widget_type => "ContentList", :widget_name => "Last Couple", :properties => { :limit => 2 } }.to_json )
    last_couple_id = result["template_file"]["id"]
    puts result = data[:auth_user].put("/api/template_files/"+last_couple_id, { :content => last_couple }.to_json )

    puts result = data[:auth_user].post("/api/templates/"+template_id+"/revisions", { :comment => "publishing" }.to_json )
  end

end

def get_bu_ids(data)
  bus = data[:business_units][:items]
  bu_ids =[]
  bus.each do |bu|
    bu_ids << bu[:id]
  end
  bu_ids
end

def update_user_bus(data)
  puts "Updating User BUs"
  users = data[:users][:items]
  bu_ids = get_bu_ids(data)
  users.each do |user|
    data[:auth_user].put('/api/users/' + user[:id] + '/business_units', { :business_unit_ids => bu_ids }.to_json )
  end
end

def update_category_bus(data)
  puts "Updating Category BUs"
  categories = data[:categories][:items]
  bu_ids = get_bu_ids(data)
  categories.each do |category|
    data[:auth_user].post('/app/blogs/' + category[:id], { :BusinessUnitIds => bu_ids, :AllBusinessUnits => true, :Attributes => { :Title => category[:name], :Description => category[:name], :ParentId => "root", :PublisherIds => [] }.to_json } )
  end
end

def update_project_bus(data)
  puts "Updating Project BUs"
  projects = data[:projects][:items]
  bu_ids = get_bu_ids(data)
  projects.each do |project|
    data[:auth_user].project.edit(project[:id],{ :business_units => bu_ids, :all_business_units => true })
  end
end

def update_content_type_bus(data)
  puts "Updating Content Type BUs"
  content_types = data[:content_types][:items]
  bu_ids = get_bu_ids(data)
  content_types.each do |ct|
    data[:auth_user].content_type.edit(ct[:id], {}, { :business_units => bu_ids, :all_business_units => true })
  end
end

def populate(data)
  new_bus = false

  if data[:business_units][:max] > data[:business_units][:count]
    new_bus = true
  end

  add_template( data )


  (data[:publishers][:count]...data[:publishers][:max]).each do |i|
    data = add_publisher(data)
  end

  (data[:business_units][:count]...data[:business_units][:max]).each do |i|
    data = add_bu(data)
  end

  if new_bus
    update_user_bus(data)
    update_category_bus(data)
    update_project_bus(data)
    update_content_type_bus(data)
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
      puts "Found Text Type"
      text_type = true
    when "page"
      puts "Found Page Type"
      page_type = true
    when "video"
      puts "Found Video Type"
      video_type = true
    when "image"
      puts "Found Image Type"
      image_type = true
    when "file"
      puts "Found File Type"
      file_type = true
    else
    end
  end

  if !text_type
    puts "Creating Text Type"
    puts ct = data[:auth_user].content_type.add("Text NP", { :primary_editor => "rich_text", :config => { :show_description => true } } )
    data[:content_types][:items] << { :name => "Text NP", :id => ct["id"], :type => "rich_text" }
    data[:content_types][:count] += 1
  end

  if !page_type
    puts "Creating Page Type"
    puts ct = data[:auth_user].content_type.add("Page NP", { :primary_editor => "rich_text", :config => { :show_description => true }, :landing_page => true })
    data[:content_types][:items] << { :name => "Page NP", :id => ct["id"], :type => "page" }
    data[:content_types][:count] += 1
  end

  if ( data[:params]["ImagePost"] == "on" && !image_type )
    puts "Creating Image Type"
    puts ct = data[:auth_user].content_type.add("Image NP", { :show_description => true, :content_score => false }, { :primary_editor => "image", :icon => "fa-picture-o" } )
    data[:content_types][:items] << { :name => "Image NP", :id => ct["id"], :type => "image" }
    data[:content_types][:count] += 1
  end

  if ( data[:params]["VideoPost"] == "on" && !video_type )
    puts "Creating Video Type"
    puts ct = data[:auth_user].content_type.add("Video NP", { :show_description => true, :content_score => false }, { :primary_editor => "video", :icon => "fa-film" } )
    data[:content_types][:items] << { :name => "Video NP", :id => ct["id"], :type => "video" }
    data[:content_types][:count] += 1
  end

  if ( data[:params]["FilePost"] == "on" && !file_type )
    puts "Creating File Type"
    puts ct = data[:auth_user].content_type.add("File NP", { :show_description => true, :content_score => false }, { :primary_editor => "file", :icon => "fa-file" } )
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


