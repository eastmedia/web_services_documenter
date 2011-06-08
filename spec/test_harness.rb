require 'yaml'
require 'sinatra'

# curl http://localhost:4567/users/1.json
get '/users/1.json' do
  "{\"user\":{\"salt\":null,\"company\":null,\"city\":null,\"address\":null,\"created_at\":\"2011-04-29T06:58:45Z\",\"title\":null,\"remember_token_expires_at\":null,\"crypted_password\":null,\"country\":null,\"company_position\":null,\"updated_at\":\"2011-04-29T06:58:45Z\",\"postal_code\":null,\"username\":\"Stephen Halter\",\"user_hash\":\"eb71af2165cd9cf7962c47c8315e350d180ebd10\",\"imported_on\":null,\"deactivated_at\":null,\"activation_code\":\"d441655d9aab0abb7a062e4090a94f2d03cbb711\",\"season_id\":3,\"public_votes_count\":0,\"id\":445220,\"failed_login_count\":0,\"remember_token\":null,\"phone\":null,\"last_name\":null,\"birthday\":null,\"address_2\":null,\"time_zone\":\"Eastern Time (US & Canada)\",\"organization\":null,\"comments_count\":0,\"activated\":true,\"reviewer_admin_id\":null,\"province\":null,\"subscribed_to_netted\":false,\"first_name\":null,\"email\":\"sjhalter@mail.usf.edu\"}}"
end

get '/dogs/1.json' do
  "{\"dog\":{\"name\":\"bruno\"}}"
end