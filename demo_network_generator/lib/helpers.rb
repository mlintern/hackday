class String
  def to_b
    return true if self.downcase == "true"
    return false if self.downcase == "false"
    return nil
  end
end

def maxed_out?(data)
  data[:count] >= data[:max]
end

def add_user(data)
  unless maxed_out?(data[:users])
    # Create New Item Here
    data[:users][:items] << { :name => Nretnil::FakeData.word, :id => Nretnil::Password.uuid }
    data[:users][:count] += 1
  end
  data
end

def add_bu(data)
  unless maxed_out?(data[:business_units])
    # Create New Item Here
    data[:business_units][:items] << { :name => Nretnil::FakeData.word, :id => Nretnil::Password.uuid }
    data[:business_units][:count] += 1
  end
  data
end

def add_category(data)
  unless maxed_out?(data[:categories])
    # Create New Item Here
    data[:categories][:items] << { :name => Nretnil::FakeData.word, :id => Nretnil::Password.uuid }
    data[:categories][:count] += 1
  end
  data
end

def add_publisher(data)
  unless maxed_out?(data[:publishers])
    # Create New Item Here
    data[:publishers][:items] << { :name => Nretnil::FakeData.word, :id => Nretnil::Password.uuid }
    data[:publishers][:count] += 1
  end
  data
end

def add_content(data)
  unless maxed_out?(data[:content])
    # Create New Item Here
    data[:content][:items] << { :name => Nretnil::FakeData.word, :id => Nretnil::Password.uuid }
    data[:content][:count] += 1
  end
  data
end

def add_content_type(data)
  unless maxed_out?(data[:projects])
    # Create New Item Here
    data[:content_type][:items] << { :name => Nretnil::FakeData.word, :id => Nretnil::Password.uuid, :type => "rich_text" }
    data[:content_type][:count] += 1
  end
  data
end

def add_project(data)
  unless maxed_out?(data[:projects])
    # Create New Item Here
    data[:projects][:items] << { :name => Nretnil::FakeData.word, :id => Nretnil::Password.uuid }
    data[:projects][:count] += 1
  end
  data
end

def populate(data)

  (0...5).each do |i|
    data = add_content(data)
    data = add_content_type(data)
    data = add_publisher(data)
    data = add_bu(data)
    data = add_project(data)
    data = add_category(data)
    data = add_user(data)
  end
  
  data
end