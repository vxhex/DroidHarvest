require 'digest/md5'
require 'fileutils'
require 'uirusu'
require_relative 'config/vtapi.rb'

LOG_FILE = 'logs/' + Time.now.strftime('%Y-%m-%d') + '.log'
#system('./extract.sh')

log = File.open(LOG_FILE, 'a')
Dir.glob('files/**/*.apk') do |apk|
    md5 = Digest::MD5.file(apk).hexdigest
    filename = File.basename(apk)
    log.write "#{filename} / #{md5}\n"
    print "Processing: #{filename}..."
    size = (File.size(apk).to_f / 2**20)
    if size <= 32.0
        if File.exists?("apks/#{md5}.apk")
            print " Sample already exists!"
        else
            results = Uirusu::VTFile.scan_file(API_KEY, apk)
            FileUtils.mv(apk, "apks/#{md5}.apk")
            print " New sample!" 
            sleep 15
        end
    else
        if size > 64.0
            print " File too damn big!"
        else
            FileUtils.mv(apk, "oversized/#{md5}.#{filename}.apk")
            print " File too big for API!"
        end
    end
    print "\n"
end
log.close
