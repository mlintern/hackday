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

  # Get all of the current data and set the counts.
  # publishers

  # pubs = data[:auth_user].content.publisher.list
  # pubs.each do |pub|
  #   data[:publishers][:items] << { :name => pub["tilte"], :id => pub["id"]}
  #   data[:publishers][:count] += 1
  # end 

  # bus
  # users
  # content_types
  # languages
  # add_projects
  # add_categories
  # content

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
  puts user = data[:auth_user].user.add(username,firstname,lastname,email)
  data[:users][:items] << { :name => firstname + " " + lastname, :id => user["Success"]["UserId"] }
  data[:users][:count] += 1
  data
end

def add_bu(data)
  pub_ids = []
  data[:publishers][:items].each do |pub|
      pub_ids << pub["id"]
  end
  name = Nretnil::FakeData.words(2)
  puts bu = data[:auth_user].bu.add(name,pub_ids)
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
  title = Nretnil::FakeData.words( rand(4) + 1 )
  # Create New Item Here
  # data[:auth_user].content.add()
  data[:content][:items] << { :name => title, :id => Nretnil::Password.uuid }
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

  (data[:languages][:count]...data[:languages][:max]).each do |i|
    lang = data[:auth_user].language.add(languages[i][:name],languages[i][:code])
    data[:languages][:items] << { :name => languages[i][:name], :id => lang["id"] }
    data[:languages][:count] += 1
  end

  (data[:projects][:count]...data[:projects][:max]).each do |i|
    data = add_project(data)
  end

  (data[:content][:count]...data[:content][:max]).each do |i|
    data = add_content(data)
  end

  return true
end


