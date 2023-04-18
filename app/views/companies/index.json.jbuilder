json.data do
  json.array! @companies do |company|
    json.user_id company.user_id
    json.name company.name
    json.phone company.phone
    json.direction company.direction
    json.mail company.mail
  end
end
