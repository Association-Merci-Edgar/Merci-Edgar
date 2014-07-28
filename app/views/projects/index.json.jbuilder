json.projects do
  json.array!(@projects) do |project|
    json.extract! project, :id, :name
  end
end