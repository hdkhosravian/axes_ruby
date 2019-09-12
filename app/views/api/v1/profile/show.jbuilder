json.first_name @profile.first_name
json.last_name @profile.last_name
json.country @profile.country
json.state @profile.state
json.city @profile.city
json.postal_code @profile.postal_code
json.address @profile.address
json.phone_number @profile.phone_number
json.user_description @profile.user_description
json.keywords @profile.keyword_list
json.avatar do
  json.partial! "api/v1/shared/image", image: @profile&.avatar
end