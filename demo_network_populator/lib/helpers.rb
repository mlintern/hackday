class String
  def to_b
    return true if self.downcase == "true"
    return false if self.downcase == "false"
    return nil
  end
end

def get_current_data(data)

  # publishers
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
  data[:users][:items] << { :name => Nretnil::FakeData.word, :id => Nretnil::Password.uuid }
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

def populate(data)

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

  add_template( data[:auth_user] )

  return true
end

def add_template (compendium)

  # Check for template and only create tmeplate if there is not one.

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

end