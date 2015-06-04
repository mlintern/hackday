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
    data[:users][:items] << { :name => user["firstname"] + " " + user["lastname"], :id => user["UserId"] }
    data[:users][:count] += 1
  end 

  # get networks categories
  categories = data[:auth_user].category.list({:NetworkId => data[:network_id]})
  
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

def add_template (compendium)

  # Check for template and only create tmeplate if there is not one.

  # curl -k https://ml2admin:wIu4e2zR9fNSi2YdBX2tJ8bDGjHQwUVJCqjGHA7n@dev.cpdm.oraclecorp.com/api/templates?network_id=dbd66dde-eb86-4842-b522-7999c98f18ce
  # templates = compendium.get("https://dev.cpdm.oraclecorp.com/api/templates?network_id=dbd66dde-eb86-4842-b522-7999c98f18ce")

  # unless templates.count > 0

    # New Template:

    # curl -k https://ml2admin:wIu4e2zR9fNSi2YdBX2tJ8bDGjHQwUVJCqjGHA7n@dev.cpdm.oraclecorp.com/api/templates/ -d '{"network":"dbd66dde-eb86-4842-b522-7999c98f18ce","name":"Network Populator Template"}'

    # New Template File using id from previous call:

    # curl -k https://ml2admin:wIu4e2zR9fNSi2YdBX2tJ8bDGjHQwUVJCqjGHA7n@dev.cpdm.oraclecorp.com/api/templates/<template_id>/template_files -d '{"name":"default.tpl"}'

    # Update Temaplate file using id from previous call:

    # curl -k https://ml2admin:wIu4e2zR9fNSi2YdBX2tJ8bDGjHQwUVJCqjGHA7n@dev.cpdm.oraclecorp.com/api/template_files/<template_file_id> -d '{"content":"<div>This is an API Test</div>"}' -XPUT

    # Publish Template using template id:

    # curl -k https://ml2admin:wIu4e2zR9fNSi2YdBX2tJ8bDGjHQwUVJCqjGHA7n@dev.cpdm.oraclecorp.com/api/templates/<template_id>/revisions -d '{"comment":"publishing”}'

    # Create AllCategoriesWidget

    # curl -k https://ml2admin:wIu4e2zR9fNSi2YdBX2tJ8bDGjHQwUVJCqjGHA7n@dev.cpdm.oraclecorp.com/api/templates/<template_id/widgets -d '{"widget_type":"AllCategories","widget_name":"Categories"}'
    # curl -k https://ml2admin:wIu4e2zR9fNSi2YdBX2tJ8bDGjHQwUVJCqjGHA7n@dev.cpdm.oraclecorp.com/api/template_files/<widget_Tempalte_file> -d '{"content":"<div>This is an API Test</div>"}' -XPUT

    # Create PostListWidget

    # curl -k https://ml2admin:wIu4e2zR9fNSi2YdBX2tJ8bDGjHQwUVJCqjGHA7n@dev.cpdm.oraclecorp.com/api/templates/<tempalte_id>/widgets -d '{"widget_type":"ContentList","widget_name":"Last Couple","properties":{"limit":"2"}}'
    # curl -k https://ml2admin:wIu4e2zR9fNSi2YdBX2tJ8bDGjHQwUVJCqjGHA7n@dev.cpdm.oraclecorp.com/api/template_files/<widget_Tempalte_file> -d '{"content":"<div>This is an API Test</div>"}' -XPUT
  # end

end

def populate(data)

  # add_template( data[:auth_user] )

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


