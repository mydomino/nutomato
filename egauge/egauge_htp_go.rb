require_relative('egauge_htp') 

#HOST_IP = '73.189.206.34'
HOST_IP = '10.1.10.180'


def get_instant_data

  begin

  	eg = EguageHtp.new(HOST_IP)
  	query_param = {tot: '', inst: '', teamstat: '', v1: ''}
  	response = eg.get_instant_data(query_param)

    puts "\nResponse is: #{response}\n"

    # save data to file - i stands for instant data
    eg.save_data_to_file('i', response.body)
  

    hash_xml = Crack::XML.parse(response.body)

    # pretty print to screen
    puts "\nPretty print the output\n"
    puts JSON.pretty_generate(hash_xml)
    

  rescue => e
  	puts "\nError! #{e}\n"
      
  end

end



def get_stored_data

  begin

  	eg = EguageHtp.new(HOST_IP)
  	query_param = {}
  	response = eg.get_stored_data(query_param)

    puts "\nResponse is: #{response}\n"

    # save data to file - s stands for stored data
    eg.save_data_to_file('s', response.body)
  


    hash_xml = Crack::XML.parse(response.body)
  
    # pretty print to screen
    puts "\nPretty print the output\n"
    puts JSON.pretty_generate(hash_xml)
    

  rescue => e
  	puts "\nError! #{e}\n"
      
  end

end



# to run: ruby egauge_htp_go.rb data_save/i-10-20-16pm.xml 
def retrieve_xml_structure
 
  begin

  	eg = EguageHtp.new('maps.googleapis.com')
  	eg.retrieve_xml_structure(ARGV.first)

  rescue => e
  	puts "\nError! #{e}\n"
  
  end
	
end



#get_instant_data
get_stored_data
#retrieve_xml_structure
