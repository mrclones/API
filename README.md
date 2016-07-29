# API
##API based on json files

This API content 2 entities - users and spaces. It requires authentication which is specified in main.rb file(user, password).

##Listen port
8443
##Methods:
  ###GET:
    /users - show all users
    /users/$user_name - show username, name, surname and age
    /spaces - show all spaces
    /spaces/$space_name - show name and id
    
  ###POST:
    /users -F "username=$user_name" -F "name=$name" -F "surname=$surname" -F "age=$age"
    /spaces -F "name=$name" -F "id=$id"
    
  ###DELETE:
    /users/$user_name
    /spaces/$space_name
