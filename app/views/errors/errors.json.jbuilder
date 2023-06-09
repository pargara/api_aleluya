# frozen_string_literal: true

json.errors do
  json.array! object.errors.full_messages do |error|
    json.message error
  end
end
