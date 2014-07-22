json.reportings do
  json.array!(@reportings) do |reporting|
    json.extract! reporting, :id
  end
end