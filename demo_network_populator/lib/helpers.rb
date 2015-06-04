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
  data[:content_types][:max] = 5
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
  # Create New Item Here
  # data[:auth_user].user.add()
  data[:users][:items] << { :name => Nretnil::FakeData.fullname, :id => Nretnil::Password.uuid }
  data[:users][:count] += 1
  data
end

def add_bu(data)
  # Create New Item Here
  # data[:auth_user].bu.add()
  data[:business_units][:items] << { :name => Nretnil::FakeData.word, :id => Nretnil::Password.uuid }
  data[:business_units][:count] += 1
  data
end

def add_category(data)
  # Create New Item Here
  # data[:auth_user].category.add()
  data[:categories][:items] << { :name => Nretnil::FakeData.word, :id => Nretnil::Password.uuid }
  data[:categories][:count] += 1
  data
end

def add_publisher(data)
  # Create New Item Here
  # data[:auth_user].publisher.add()
  data[:publishers][:items] << { :name => Nretnil::FakeData.word, :id => Nretnil::Password.uuid }
  data[:publishers][:count] += 1
  data
end

def add_content(data)
  # Create New Item Here
  # data[:auth_user].content.add()
  data[:content][:items] << { :name => Nretnil::FakeData.words( rand(4) + 1 ), :id => Nretnil::Password.uuid }
  data[:content][:count] += 1
  data
end

def add_language(data)
  # Create New Item Here
  # data[:auth_user].language.add()
  data[:languages][:items] << { :name => Nretnil::FakeData.word, :id => Nretnil::Password.uuid }
  data[:languages][:count] += 1
  data
end

def add_content_type(data)
  # Create New Item Here
  # data[:auth_user].content_type.add()
  data[:content_types][:items] << { :name => Nretnil::FakeData.word, :id => Nretnil::Password.uuid, :type => "rich_text" }
  data[:content_types][:count] += 1
  data
end

def add_project(data)
  # Create New Item Here
  # data[:auth_user].project.add()
  data[:projects][:items] << { :name => Nretnil::FakeData.word, :id => Nretnil::Password.uuid }
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

  (data[:content_types][:count]...data[:content_types][:max]).each do |i|
    data = add_content_type(data)
  end

  (data[:languages][:count]...data[:languages][:max]).each do |i|
    data = add_language(data)
  end

  (data[:projects][:count]...data[:projects][:max]).each do |i|
    data = add_project(data)
  end

  (data[:categories][:count]...data[:categories][:max]).each do |i|
    data = add_category(data)
  end

  (data[:content][:count]...data[:content][:max]).each do |i|
    data = add_content(data)
  end

  return true
end


