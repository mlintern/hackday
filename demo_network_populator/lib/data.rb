def default_data
  return {
    :auth_user => nil,
    :business_units => { :count => 0, :items => [], :max => 5 },
    :categories => { :count => 0, :items => [], :max => 20 },
    :content => { :count => 0, :items => [], :max => 100 },
    :content_types => { :count => 0, :items => [], :max => 5 },
    :languages => { :count => 0, :items => [], :max => 10 },
    :network_id => nil,
    :projects => { :count => 0, :items => [], :max => 10 },
    :publishers => { :count => 0, :items => [], :max => 10 },
    :users => { :count => 0, :items => [], :max => 15 }
  }
end

def images
  return [
    "path to image",
    "path to image"
  ]
end

def languages
  return [
    {:name => "English", :code => "EN"},
    {:name => "Spanish", :code => "ES"},
    {:name => "French", :code => "FR"},
    {:name => "German", :code => "DE"},
    {:name => "Greek", :code => "EL"},
    {:name => "Tamil", :code => "TA"},
    {:name => "Russian", :code => "RU"},
    {:name => "Portuguese", :code => "PT"},
    {:name => "Arabic", :code => "AR"},
    {:name => "Swedish", :code => "SV"},
    {:name => "Dutch", :code => "NL"},
    {:name => "Italian", :code => "IT"},
    {:name => "Japanese", :code => "JA"}
  ]
end