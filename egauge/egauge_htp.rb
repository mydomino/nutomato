require 'httparty'
require 'json'
require 'crack' 


class EguageHtp
	include HTTParty

	DATA_SAVE_FOLDER = 'data_save' 
	
	#debug_output STDOUT


	def initialize(host_ip)
		@host_ip = host_ip
		#base_uri = host_ip
	end



	def get_instant_data(query_options)

	  puts "eGauge Instantaneous Data\n"

	  # set the base URL 
	  self.class.base_uri(@host_ip)

	  paswd = ENV['egauge_password']
    puts "paswd is: #{paswd}"

    # set digest authentication
	  self.class.digest_auth('owner', paswd)

	  url = "http://#{@host_ip}/cgi-bin/egauge?tot&inst&teamstat&v1"
    
    puts "\nQuery options is: #{query_options}"

    
    #response = self.class.get("/cgi-bin/egauge", query: query_options)
    response = self.class.get(url)
    puts "\nParams sent to URL is: #{response.request.last_uri.to_s}"

	  if response.success?
      response
    else
      raise response.response
    end
  
  end


  def get_stored_data(query_options)

	  puts "eGauge Stored Data\n"

	  # set the base URL 
	  self.class.base_uri(@host_ip)

	  paswd = ENV['egauge_password']
    puts "paswd is: #{paswd}"

    # set digest authentication
	  self.class.digest_auth('owner', paswd)

	  url = "http://#{@host_ip}/cgi-bin/egauge-show?a"
    
    puts "\nQuery options is: #{query_options}"

    
    #response = self.class.get("/cgi-bin/egauge", query: query_options)
    response = self.class.get(url)
    puts "\nParams sent to URL is: #{response.request.last_uri.to_s}"

	  if response.success?
      response
    else
      raise response.response
    end
  
  end

  def save_data_to_file(file_prefix, data_str)

    # check to see if the data folder exist, if not create it
    full_path = File.expand_path("~/#{DATA_SAVE_FOLDER}")
    puts "\nFull save path is: #{full_path}"

    if !File.exist?(full_path) 
      Dir.mkdir(full_path)
      puts "\nPath #{full_path} was created."
    end

  	date_time_str = (file_prefix == 'i') ? DateTime.now.strftime('%m-%d-%y%P') : DateTime.now.strftime('%m-%d-%y_%I-%M-%S%P')
    puts "\nTime is now #{date_time_str}"
    file_name_path = full_path + '/' + file_prefix + '-' + date_time_str + '.xml'

    # append the response to file with time-stamp as file name
    File.open(file_name_path, "a") do |file|
    	file.write(data_str)
    end
  	
  end


  def retrieve_xml_structure(file_name)

	puts "Retrieve_xml_structure .\n\n"
	
 
  begin

  	xml_hash = Crack::XML.parse(File.read(file_name))

  	#pretty print with JSON
    puts "\nPretty print the output with JSON\n"
    puts JSON.pretty_generate(xml_hash)

  rescue => e
  	puts "\nError! #{e}\n"
  
  end
	
end



  def get_test_data(query_options)

	  puts "Google MAP API Data\n"
	  self.class.base_uri 'maps.googleapis.com'

    puts "\nQuery options is: #{query_options}"

    
    #response = self.class.get("http://maps.googleapis.com/maps/api/geocode/xml?address=11234+Broadway,+New+York,+NY&sensor=false")
    response = self.class.get("/maps/api/geocode/xml", query: query_options)
    puts "\nParams sent to URL is: #{response.request.last_uri.to_s}"

    
    puts "\nParams sent to URL is: #{response.request.last_uri.to_s}"

	  if response.success?
      response
    else
      raise response.response
    end
  
  end





end