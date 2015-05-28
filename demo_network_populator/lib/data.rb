def default_data
  return {
    :auth_user => nil,
    :business_units => { :count => 0, :items => [], :max => 5 },
    :categories => { :count => 0, :items => [], :max => 20 },
    :content => { :count => 0, :items => [], :max => 100 },
    :content_type => { :count => 0, :items => [], :max => 5 },
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