json.extract! user, :id, :email, :name, :pro_pic_url, :role
if user.name
    json.name user.name
else
   json.name user.email
end
