# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cats = Cat.create([
  # note: userid was added, but isn't accounted for here.
  { name: "Morris", age: 10, sex: "M", color: "orange" }, 
  { name: "Fluffy", age: 8, sex: "F", color: "white" }])
  
# :cat_id, :start_date, :end_date,
# cat 1: morris
# cat 2: fluffy
requests = CatRentalRequest.create([
  { cat_id: 1, start_date: "2014-09-01", end_date: "2014-09-04" , status: "APPROVED" },
  { cat_id: 1, start_date: "2014-09-07", end_date: "2014-09-10", status: "APPROVED" },
  { cat_id: 1, start_date: "2014-09-13", end_date: "2014-09-16", status: "APPROVED" } 
   ])
   
#test. should break. 
false && 
collide = CatRentalRequest.create([
  { cat_id: 1, start_date: "2014-09-02", end_date: "2014-09-05" , status: "APPROVED" }])

# should be fine.   
false &&
collide = CatRentalRequest.create([
  { cat_id: 1, start_date: "2014-09-19", end_date: "2014-09-22" , status: "APPROVED" }])  