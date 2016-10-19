require 'rest-client'
require 'json'


DATA_SAVE_FOLDER = 'data_save' 


######################################################


def with_xml

	require 'xmlsimple'
  require 'awesome_print'
  
  

	puts "With XML .\n\n"
 
  begin

    url = 'http://maps.googleapis.com/maps/api/geocode/xml?address=1400+Broadway,+New+York,+NY&sensor=false'
    response = RestClient.get(url)

    puts "\nResponse is: #{response}\n"

    hash_xml = XmlSimple.xml_in(response.body)
  
    # pretty print to screen
    puts "\nPretty print the output\n"
    puts JSON.pretty_generate(hash_xml)
    #ap(hash_xml)
    
  rescue => e
  	puts "\nError! #{e}\n"
  
  end

end






##########################################################

def with_json

  puts "With JSON .\n\n"
 
  begin
    url = 'https://api.spotify.com/v1/search?type=artist&q=tycho'
    response = RestClient.get(url)
    a = JSON.parse(response)
    #puts a 
    puts JSON.pretty_generate(a)
  rescue => e
  	puts "\nError! #{e}\n"
  
  end
	
end



###############################################


def xml_to_json

	# Convert XML to JSON using Ruby and ActiveSupport
	# to Run this, type: ruby egauge_data_query.rb  sample_xml_1.xml b.out

  require 'rubygems'
  require 'active_support'
  require 'active_support/core_ext'
  require 'json'
  require 'awesome_print'
  
  xml = File.open(ARGV.first).read
  
  json = Hash.from_xml(xml).to_json
  
  # write to file
  #File.open(ARGV.last, 'w+').write json
  File.open(ARGV.last, 'w') do |f|

    # this does not work - Yong
    #f.write json.awesome_inspect
    f.write json
  end

  # pretty print to screen
  #ap(JSON.parse(json))
  puts JSON.pretty_generate(JSON.parse(json))
	
end




#############################################################

def xml_to_hash

	# Convert XML to hash using XmlSimple
	# to Run this, type: ruby egauge_data_query.rb  sample_xml_2.xml | tee c.out


  require 'xmlsimple'
  require 'awesome_print'
  
  hash_xml = XmlSimple.xml_in(ARGV.first)
  
  # pretty print to screen
  puts JSON.pretty_generate(hash_xml)
  #ap(hash_xml)
	
end




#############################################################


def with_default

	puts "With Default .\n\n"
	
 
  begin
    #url = 'http://requestb.in/1na2m6p1'
    url = 'http://maps.googleapis.com/maps/api/geocode/xml?address=11234+Broadway,+New+York,+NY&sensor=false'
    response = RestClient.get(url)
    
    puts response

    #resp_body = response.body
    #puts (response == resp_body)? "\n\nresp_body == resp:TRUE" : "\n\nresp_body == resp:FALSE"

    #date_time_str = DateTime.now.strftime('%m-%d-%y_%I:%M:%S%p')
    date_time_str = DateTime.now.strftime('%m-%d-%y%P')
    puts "\nTime is now #{date_time_str}"
    file_name_path = DATA_SAVE_FOLDER + '/' + date_time_str + '.xml'

    # append the response to file with time-stamp as file name
    File.open(file_name_path, "a") do |file|
    	file.write(response.body)
    end

  rescue => e
  	puts "\nError! #{e}\n"
  
  end

end

######################################################

def retrieve_xml_structure

	puts "Retrieve_xml_structure .\n\n"

	require 'crack' # for xml and json
	
 
  begin

  	xml_hash = Crack::XML.parse(File.read('sample_xml_4.xml'))

  	#pretty print with JSON
    puts "\nPretty print the output with JSON\n"
    puts JSON.pretty_generate(xml_hash)

  rescue => e
  	puts "\nError! #{e}\n"
  
  end
	
end

######################################################


def with_crack_xml

	require 'crack' # for xml and json
  
  

	puts "With Crack XML .\n\n"
 
  begin

    url = 'http://maps.googleapis.com/maps/api/geocode/xml?address=1400+Broadway,+New+York,+NY&sensor=false'
    response = RestClient.get(url)

    puts "\nResponse is: #{response}\n"

    xml_hash = Crack::XML.parse(response.body)

  	#pretty print with JSON
    puts "\nPretty print the output with JSON\n"
    puts JSON.pretty_generate(xml_hash)

    
  rescue => e
  	puts "\nError! #{e}\n"
  
  end

end






##########################################################




with_default
#with_xml()
#with_crack_xml
#xml_to_json
#xml_to_hash
#retrieve_xml_structure