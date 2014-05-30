require 'digest/md5'
require 'fileutils'
require 'rest_client'
require_relative 'config/vtapi.rb'

count = 0;
File.readlines('hashes.txt').each_with_index do |line, idx|
    hash = line.strip
	unless File.exists?("reports/#{hash}.vtotal.json")
	    count += 1
	    print "#{count}. #{hash}\n"
	    response = RestClient.post 'https://www.virustotal.com/vtapi/v2/file/report',
                                       :apikey => API_KEY,
                                       :resource => hash,
                                       :allinfo => 1
            if response.code == 200
                results = JSON.pretty_generate(JSON.parse(response))
            else
                results = "VT error #{response.code}"
            end
            File.open("reports/#{hash}.vtotal.json", 'w') {|file| file.write(results)}
	    sleep 8
	end
	break if count >= 1000
end
