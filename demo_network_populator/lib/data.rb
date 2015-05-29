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
    {"English","EN"}
    {"Spanish","ES"},
    {"French","FR"},
    {"German","DE"},
    {"Greek","EL"},
    {"Tamil","TA"},
    {"Russian","RU"},
    {"Portuguese","PT"},
    {"Arabic","AR"},
    {"Swedish","SV"},
    {"Dutch","NL"},
    {"Italian","IT"},
    {"Japanese","JA"}
  ]
end