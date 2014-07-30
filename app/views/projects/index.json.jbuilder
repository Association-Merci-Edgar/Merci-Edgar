json.projects do
  json.array!(@projects) do |project|
    json.extract! project, :id, :name, :avatar_url
  end
end