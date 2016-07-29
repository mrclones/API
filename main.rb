require 'sinatra'
require 'sinatra/base'
require 'sinatra/basic_auth'
require 'json'

# Environment
set :bind, '*'
set :port, '8443'

# Variables
$directory = "/app"

# Authorization
authorize do |username, password|
    username == "user" && password == "toor"
end

# Invitation
protect do

# Invitation
	get "/?" do
		content_type :json
		{ :message => "Hello. This is REST API created by Mr. Clones." }.to_json
	end

# GET
# Case
# 1 argument
	get "/:link/?" do
		if "#{params['link']}" === "users" then
			Dir.chdir "#$directory/users/"
			files = Dir.glob("*.json")
			content_type :json
			{ :message => "Please specify user name: /users/$user_name", :users => files.to_json }.to_json
		elsif "#{params['link']}" === "spaces" then
			Dir.chdir "#$directory/spaces/"
			files = Dir.glob("*.json")
			content_type :json
			{ :message => "Please specify space name: /spaces/$space_name", :spaces => files.to_json }.to_json
		else
			content_type :json
			{ :message => "The \"#{params['link']}\" is not valid link. Please use one of these: /users or /spaces" }.to_json
		end 
	end
# 2 arguments
	get "/:link/:name/?" do
		if "#{params['link']}" === "users" then
			Dir.chdir "#$directory/users/"
			source_file = "#{params['name']}.json"
			if File.file?(source_file) then
				file = File.read(source_file)
				data_hash = JSON.parse(file)
				content_type :json
            	{ :username => data_hash['username'], :name => data_hash['name'], :surname => data_hash['surname'], :age => data_hash['age'] }.to_json
            else
            	content_type :json
				{ :message => "The user #{params['name']} does not exist." }.to_json
            end
		elsif  "#{params['link']}" === "spaces" then
			Dir.chdir "#$directory/spaces/"
			source_file = "#{params['name']}.json"
			if File.file?(source_file) then
				file = File.read(source_file)
				data_hash = JSON.parse(file)
				content_type :json
            	{ :name => data_hash['name'], :id => data_hash['id'] }.to_json
            else
            	content_type :json
				{ :message => "The space #{params['name']} does not exist." }.to_json
            end
		else
			content_type :json
			{ :message => "The \"#{params['link']}\" is not valid link. Please use one of these: /users or /spaces" }.to_json
		end
	end

# POST
	post "/:link/?" do
		if "#{params['link']}" === "users" then
			Dir.chdir "#$directory/users/"
			username = params[:username]
			name = params[:name]
			surname = params[:surname]
			age = params[:age]
			source_file = "#{params['username']}.json"
			if File.file?(source_file) then
				content_type :json
				{ :message => "The user #{params['username']} already exists." }.to_json
			else
				file = File.open(source_file, "w")
  				file.write("{\n")
  				file.write("  \"username\":\"#{params['username']}\",\n")
  				file.write("  \"name\":\"#{params['name']}\",\n")
  				file.write("  \"surname\":\"#{params['surname']}\",\n")
  				file.write("  \"age\":\"#{params['age']}\"\n")
  				file.write("}\n")
  				file.close
  				content_type :json
				{ :message => "The user #{params['username']} has been created." }.to_json
			end
		elsif  "#{params['link']}" === "spaces" then
			Dir.chdir "#$directory/spaces/"
			name = params[:name]
			id = params[:id]
			source_file = "#{params['name']}.json"
			if File.file?(source_file) then
				content_type :json
				{ :message => "The space #{params['name']} already exists." }.to_json
			else
				file = File.open(source_file, "w")
  				file.write("{\n")
  				file.write("  \"name\":\"#{params['name']}\",\n")
  				file.write("  \"id\":\"#{params['id']}\"\n")
  				file.write("}\n")
  				file.close
				content_type :json
				{ :message => "The space #{params['name']} has been created." }.to_json
			end
		else
			content_type :json
			{ :message => "The \"#{params['link']}\" is not valid link. Please use one of these: /users or /spaces" }.to_json
		end
	end

# DELETE
	delete "/:link/:name" do
		if "#{params['link']}" === "users" then
			Dir.chdir "#$directory/users/"
			source_file = "#{params['name']}.json"
			if File.file?(source_file) then
				File.delete(source_file)
				content_type :json
				{ :message => "The user #{params['name']} has been deleted." }.to_json
            else
            	content_type :json
				{ :message => "The user #{params['name']} does not exist." }.to_json
			end
		elsif  "#{params['link']}" === "spaces" then
			Dir.chdir "#$directory/spaces/"
			source_file = "#{params['name']}.json"
			if File.file?(source_file) then
				File.delete(source_file)
				content_type :json
				{ :message => "The space #{params['name']} has been deleted." }.to_json
            else
            	content_type :json
				{ :message => "The space #{params['name']} does not exist." }.to_json
			end
		else
			content_type :json
			{ :message => "The \"#{params['link']}\" is not valid link. Please use one of these: /users or /spaces" }.to_json
		end

	end

end
