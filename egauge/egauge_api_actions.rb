#
require 'rest-client'
require 'json'
require 'xmlsimple'
require 'awesome_print'
require 'crack' 


HOST_IP = '10.1.10.180'
DATA_SAVE_FOLDER = 'data_save'
USER = 'owner'



def get_instant_data

	puts "eGauge Instantaneous Data\n"
 
  begin

    url = "http://#{HOST_IP}/cgi-bin/egauge?tot&inst&teamstat&v1"
    paswd = ENV['egauge_password']

    puts "paswd is: #{paswd}"
    
    puts "\nParams sent to URL is: #{url}"
    response = RestClient.get(url)

    puts "\nResponse is: #{response}\n"

    hash_xml = Crack::XML.parse(response.body)
  
    # pretty print to screen
    puts "\nPretty print the output\n"
    puts JSON.pretty_generate(hash_xml)
    

  rescue => e
  	puts "\nError! #{e}\n"
  
  end

end

#######################################################################



def get_stored_data

	puts "eGauge Stored Data\n"
 
  begin

    paswd = ENV['egauge_password']
    puts "paswd is: #{paswd}"

    #url = "https://#{USER}:#{paswd}@#{HOST_IP}//cgi-bin/egauge-show?a"
    url = "https://#{HOST_IP}//cgi-bin/egauge-show?a"
    
    puts "\nParams sent to URL is: #{url}"

    response = RestClient::Request.new(
      :method => :get,
      :url => url,
      :user => USER,
      :password => paswd,
      :verify_ssl => false
    ).execute




    #response = RestClient.get(url, {:authorization => "Basic #{Base64.strict_encode64("#{USER}:#{paswd}")}"})
    
 
    puts "\nResponse is: #{response}\n"

    #hash_xml = XmlSimple.xml_in(response)
    hash_xml_body = Crack::XML.parse(response.body)
    puts "\nRaw hash_xml_body: #{hash_xml_body}"
  
    # pretty print to screen
    # puts "\nPretty print the output\n"
    # ap(hash_xml)

    #pretty print with JSON
    #puts "\nPretty print the output with JSON\n"
    #puts JSON.pretty_generate(hash_xml)

    puts "\nPretty print the XML body with JSON\n"
    puts JSON.pretty_generate(hash_xml_body)


    #date_time_str = DateTime.now.strftime('%m-%d-%y_%I:%M:%S%p')
    date_time_str = DateTime.now.strftime('%m-%d-%Y%P')
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

#######################################################################





#get_instant_data
get_stored_data