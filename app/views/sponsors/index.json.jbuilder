json.array!(@sponsors) do |sponsor|
  json.extract! sponsor, :id, :company_name, :tier, :money_given, :has_paid
  json.url sponsor_url(sponsor, format: :json)
end
