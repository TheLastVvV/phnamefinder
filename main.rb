puts "********** Welcome to the Phone Number Lookup Tool **********\n\n"
puts "***** you can find names associated to any phone number *****\n\n"
puts "********* Phnamefinder 1.0 by Thelastvvv.com ********************\n\n"
require 'json'
require 'net/http'
require 'uri'


# Define a hash of country codes and their names
country_codes = {
'AE' =>  'United Arab Emirates',
'BH' => 'Bahrain',
'CY' => 'Cyprus',
'EG' => 'Egypt',
'IR' => 'Iran',
'IQ' => 'Iraq',
'IL' => 'Israel',
'JO' => 'Jordan',
'KW' => 'Kuwait',
'LB' => 'Lebanon',
'LY' => 'Libya',
'MT' => 'Malta',
'MR' => 'Mauritania',
'MA' => 'Morocco',
'OM' => 'Oman',
'PS' => 'Palestine, State of',
'QA' => 'Qatar',
'SA' => 'Saudi Arabia',
'SY' => 'Syrian Arab Republic',
'TN' => 'Tunisia',
'TR' => 'Turkey',
'YE' => 'Yemen',
'AF' => 'Afghanistan',
'BD' => 'Bangladesh',
'BT' => 'Bhutan',
'IN' => 'India',
'MV' => 'Maldives',
'NP' => 'Nepal',
'PK' => 'Pakistan',
'LK' => 'Sri Lanka',
'AM' => 'Armenia',
'AZ' => 'Azerbaijan',
'GE' => 'Georgia',
'BY' => 'Belarus',
'CN' => 'China',
'EE' => 'Estonia',
'FI' => 'Finland',
'KZ' => 'Kazakhstan',
'KP' => 'North Korea',
'LV' => 'Latvia',
'LT' => 'Lithuania',
'MN' => 'Mongolia',
'NO' => 'Norway',
'PL' => 'Poland',
'KR' => 'South Korea',
'TJ' => 'Tajikistan',
'TM' => 'Turkmenistan',
'UA' => 'Ukraine',
'UZ' => 'Uzbekistan',



  # Add more country codes and names here
}


# Print the list of country codes for the user to choose from
puts 'Select a country code:'
country_codes.each do |code, name|
  puts "#{code} - #{name}"
end

# Get the user's input for the country code
print 'Enter the country code: '
country_code = gets.chomp.upcase

# Check if the entered country code is valid
unless country_codes.key?(country_code)
  puts 'Invalid country code'
  exit
end

# Get the phone number from the user
print 'Enter the phone number: '
phone_number = gets.chomp

# Call the API with the phone number and country code
begin
  url = URI("https://devappteamcall.site/data/search_name?country=#{country_code}")
  payload = {
    'phoneNumber' => phone_number
  }
  headers = {
    'Authorization' => 'Basic YWEyNTAyOnp1enVBaGgy',
    'User-Agent' => 'Dalvik/2.1.0 (Linux; U; Android 5.1.1; SM-G965N Build/QP1A.190711.020)',
    'Host' => 'devappteamcall.site',
    'Connection' => 'Keep-Alive',
    'Accept-Encoding' => 'gzip',
    'Content-Type' => 'application/x-www-form-urlencoded',
    'Content-Length' => '21'
  }
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  request = Net::HTTP::Post.new(url, headers)
  request.set_form_data(payload)
  response = http.request(request)
  id_s = JSON.parse(response.body)['result']
  jsona = JSON.parse(id_s)
  naMes = []
  jsona.each do |i|
    naMes.push(i['Name'])
  end

  # Write the results to a text file
  File.open('output.txt', 'w') do |f|
    naMes.each { |name| f.puts(name) }
  end

  puts 'Done | Results written to output.txt'
rescue
  puts 'Something went wrong '

end
