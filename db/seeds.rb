# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

pass='vtr512'


User.find_or_create_by_subdomain nick: "empresa", password:pass, subdomain: "www", sponsor_id:1, email1: "empresa@sbmmn.com"
User.find_or_create_by_subdomain nick:"Humbert " , password:pass, subdomain: "hribeiro", sponsor_id:1, email1: "hribeiro@sbmmn.com"

