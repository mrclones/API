# API
##API based on json files

This API content 2 entities - users and spaces. It requires authentication which is specified in main.rb file(user, password).

##Listen port
8443
##Methods:
###GET
####Show all users
    /users
####Show username, name, surname and age
    /users/$user_name
####Show all spaces
    /spaces
####Show name and id
    /spaces/$space_name
    
###POST
####Create user
    /users -F "username=$user_name" -F "name=$name" -F "surname=$surname" -F "age=$age"
####Create space
    /spaces -F "name=$name" -F "id=$id"
    
###DELETE
####Delete user
    /users/$user_name
####Delete space
    /spaces/$space_name
