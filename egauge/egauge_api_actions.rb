#
require 'rest-client'
require 'json'
require 'xmlsimple'
require 'awesome_print'



def get_instant_data

	puts "eGauge Instantaneous Data\n"
 
  begin

    #url = 'https://ip/cgi-bin/egauge?tot&inst'
    url = 'http://maps.googleapis.com/maps/api/geocode/xml?address=1400+Broadway,+New+York,+NY&sensor=false'
    response = RestClient.get(url)

    puts "\nResponse is: #{response}\n"

    hash_xml = XmlSimple.xml_in(response.body)
  
    # pretty print to screen
    puts "\nPretty print the output\n"
    ap(hash_xml)

  rescue => e
  	puts "\nError! #{e}\n"
  
  end

end

#######################################################################



def get_stored_data

	puts "eGauge Stored Data\n"
 
  begin

    #url = 'https://ip/cgi-bin/egauge?tot&inst'
    url = 'http://maps.googleapis.com/maps/api/geocode/xml?address=1400+Broadway,+New+York,+NY&sensor=false'
    response = RestClient.get(url)

    puts "\nResponse is: #{response}\n"

    hash_xml = XmlSimple.xml_in(response.body)
  
    # pretty print to screen
    puts "\nPretty print the output\n"
    ap(hash_xml)

  rescue => e
  	puts "\nError! #{e}\n"
  
  end

end

#######################################################################





#get_instant_data
get_stored_data