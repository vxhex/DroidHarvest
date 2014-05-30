require 'watir'
require_relative 'config/wbapi.rb'

b = Watir::Browser.new :chrome
b.goto WB_URL

b.div(:id, 'toolbar-open').wait_until_present

File.readlines('magnets.txt').each_with_index do |line, idx|
    print "#{idx}: #{line}"
    b.div(:id, 'toolbar-open').click
    b.text_field(:id, 'torrent_upload_url').set line
    b.link(:id, 'upload_confirm_button').click
    sleep rand(3..5)
end

