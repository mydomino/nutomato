#
require 'rest-client'
require 'json'



puts "eGauge Instantaneous Data\n"
 
begin
  url = 'https://ip/cgi-bin/egauge?tot&inst'
  response = RestClient.get(url)
  a = JSON.parse(response)
  #puts a 
  puts JSON.pretty_generate(a)
rescue => e
	puts "\nError! #{e}\n"

end