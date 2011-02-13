# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Event.create( 
  :name=>"BarCamp Philly", 
  :site_url=>"http://barcampphilly.org", 
  :image_url=>"http://evbdn.eventbrite.com/s3-s3/eventlogos/451445/422200814-2.png",
  :description=>"Saturday November 13th 2010")
  
Event.create( 
  :name=>"BohConf", 
  :site_url=>"http://bohconf.com/", 
  :image_url=>"http://blog.smartlogicsolutions.com/wp-content/uploads/2010/06/nerdy_boh_02-150x150.png",
  :description=>"May 16th - 19th 2011")


