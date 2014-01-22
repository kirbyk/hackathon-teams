json.array!(@representatives) do |representative|
  json.extract! representative, :id, :fname, :lname, :title, :email
  json.url representative_url(representative, format: :json)
end
