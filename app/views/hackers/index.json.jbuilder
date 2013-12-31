json.array!(@hackers) do |hacker|
  json.extract! hacker, :id, :fname, :lname, :email, :github, :tshirt_size, :why
  json.url hacker_url(hacker, format: :json)
end
