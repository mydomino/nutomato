#!/usr/bin/env ruby

# ref: http://www.rubydoc.info/gems/rest-client/1.6.3/RestClient

# GET (Specific Record)

require 'base64'
 
 # https://rubygems.org/gems/rest-client
 # Example install using gem
 #   gem install rest-client
 require 'rest-client'
 
 # Set the request parameters
 host = 'https://my_egauge.domino.service-now.com'
 user = 'admin'
 pwd = 'admin'
 sys_id = 'c5d0db50eb2211004d7763fba206fe13'
 
 begin
   # Get the incident with sys_id declared above
   response = RestClient.get("#{host}/api/now/mydomino/incident/#{sys_id}",
                             {:authorization => "Basic #{Base64.strict_encode64("#{user}:#{pwd}")}",
                              :accept => 'application/json'})
   puts "#{response.to_str}"
   puts "Response status: #{response.code}"
   response.headers.each { |k,v|
     puts "Header: #{k}=#{v}"
   }
 
 rescue => e
   puts "ERROR: #{e}"
 end


 ###############################################


  # GET (All Records) 


 
 require 'base64'
 
 # https://rubygems.org/gems/rest-client
 # Example install using gem
 #   gem install rest-client
 require 'rest-client'
 
 # Set the request parameters
 host = 'https://my_egauge.domino.service-now.com'
 user = 'admin'
 pwd = 'admin'
 
 begin
   # Get ALL incidents
   response = RestClient.get("#{host}/api/now/mydomino/incident",
                             {:authorization => "Basic #{Base64.strict_encode64("#{user}:#{pwd}")}",
                              :accept => 'application/json'})
   puts "#{response.to_str}"
   puts "Response status: #{response.code}"
   response.headers.each { |k,v|
     puts "Header: #{k}=#{v}"
   }
 
 rescue => e
   puts "ERROR: #{e}"
 end

############################

#POST 

require 'base64'
 
 # https://rubygems.org/gems/json
 # Example install using gem
 #   gem install json
 require 'json'
 
 # https://rubygems.org/gems/rest-client
 # Example install using gem
 #   gem install rest-client
 require 'rest-client'
 
 # Set the request parameters
 host = 'https://my_egauge.domino.service-now.com'
 user = 'admin'
 pwd = 'admin'
 
 request_body_map = {
   :active => 'false',
   :business_stc => '13203',
   :calendar_stc => '86415',
   :category => 'network',
   :description => 'User cannot access email on mail.company.com.',
   :escalation => '0',
   :impact => '1',
   :incident_state => '7',
   :knowledge => 'false',
   :made_sla => 'false',
   :notify => '1',
   :number => 'INC0000001',
   :priority => '2',
   :severity => '1',
   :short_description => 'Cannot read email',
   :state => '7',
   :sys_class_name => 'incident',
   :sys_created_by => 'pat',
   :sys_mod_count => '19',
   :sys_updated_by => 'glide.maint',
   :urgency => '1',
 }
 
 begin
   response = RestClient.post("#{host}/api/now/mydomino/incident",
                              request_body_map.to_json,    # Encode the entire body as JSON
                              {:authorization => "Basic #{Base64.strict_encode64("#{user}:#{pwd}")}",
                               :content_type => 'application/json',
                               :accept => 'application/json'})
   puts "#{response.to_str}"
   puts "Response status: #{response.code}"
   response.headers.each { |k,v|
     puts "Header: #{k}=#{v}"
   }
 
 rescue => e
   puts "ERROR: #{e}"
 end




 ########################################################

 # Put

 require 'base64'
 
 # https://rubygems.org/gems/json
 # Example install using gem
 #   gem install json
 require 'json'
 
 # https://rubygems.org/gems/rest-client
 # Example install using gem
 #   gem install rest-client
 require 'rest-client'
 
 # Set the request parameters
 host = 'https://my_egauge.domino.service-now.com'
 user = 'admin'
 pwd = 'admin'
 sys_id = 'd71da88ac0a801670061eabfe4b28f77'
 
 begin
   # First GET the record
   response = RestClient.get("#{host}/api/now/mydomino/incident/#{sys_id}",
                             {:authorization => "Basic #{Base64.strict_encode64("#{user}:#{pwd}")}",
                              :accept => 'application/json'})
   if response.code != 200
     puts "#{response.to_str}"
     puts "Response status: #{response.code}"
     response.headers.each { |k,v|
       puts "Header: #{k}=#{v}"
     }
     abort "GET request failed"
   end
 
   # decode the response
   result_hash = JSON.parse(response.to_str)
   incident_details = result_hash['result']
 
   # Update the incident record --- Let's prepend 'Updated via REST! ' to the short_description field
   incident_details['short_description'] = "Updated via REST! #{incident_details['short_description']}"
 
   # PUT the entire record to update it
   response = RestClient.put("#{host}/api/now/mydomino/incident/#{sys_id}",
                             incident_details.to_json,      # Re-encode the entire incident as JSON
                             {:cookies => response.cookies, # Note the re-use of cookies
                              :content_type => 'application/json',
                              :accept => 'application/json'})
   puts "#{response.to_str}"
   puts "Response status: #{response.code}"
   response.headers.each { |k,v|
     puts "Header: #{k}=#{v}"
   }
 
 rescue => e
   puts "ERROR: #{e}"
 end



 ######################################

 # PATCH

 require 'base64'
 
 # https://rubygems.org/gems/json
 # Example install using gem
 #   gem install json
 require 'json'
 
 # https://rubygems.org/gems/rest-client
 # Example install using gem
 #   gem install rest-client
 require 'rest-client'
 
 # Set the request parameters
 host = 'https://my_egauge.domino.service-now.com'
 user = 'admin'
 pwd = 'admin'
 sys_id = 'd71da88ac0a801670061eabfe4b28f77'
 
 request_body_map = {
   :short_description => 'New short description',
 }
 
 begin
   # PATCH the record with just the field you want to update
   response = RestClient.patch("#{host}/api/now/mydomino/incident/#{sys_id}",
                               request_body_map.to_json,    # Encode the short_description as JSON
                               {:authorization => "Basic #{Base64.strict_encode64("#{user}:#{pwd}")}",
                                :content_type => 'application/json',
                                :accept => 'application/json'})
   puts "#{response.to_str}"
   puts "Response status: #{response.code}"
   response.headers.each { |k,v|
     puts "Header: #{k}=#{v}"
   }
 
 rescue => e
   puts "ERROR: #{e}"
 end


 ##################################

 # Delete

 require 'base64'
 
 # https://rubygems.org/gems/rest-client
 # Example install using gem
 #   gem install rest-client
 require 'rest-client'
 
 # Set the request parameters
 host = 'https://my_egauge.domino.service-now.com'
 user = 'admin'
 pwd = 'admin'
 sys_id = 'd71da88ac0a801670061eabfe4b28f77'
 
 begin
   # Delete the incident with sys_id declared above
   response = RestClient.delete("#{host}/api/now/mydomino/incident/#{sys_id}",
                                {:authorization => "Basic #{Base64.strict_encode64("#{user}:#{pwd}")}",
                                 :accept => 'application/json'})
   puts "#{response.to_str}"
   puts "Response status: #{response.code}"
   response.headers.each { |k,v|
     puts "Header: #{k}=#{v}"
   }
 
 rescue => e
   puts "ERROR: #{e}"
 end