json.email @user.email
json.token do
  json.partial! "api/v1/tokens/show", token: @user.token
end
