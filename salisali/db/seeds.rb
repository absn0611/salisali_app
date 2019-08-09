# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AreaMaster.create(id:"admin",area_name:"admin",distance_from_store:0)
User.create(name:"admin",mail:"admin",address:"admin",area_master_id:"admin",password:"admin", password_confirmation:"admin",admin:"true")