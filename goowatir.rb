require 'watir'

b = Watir::Browser.new :chrome
b.goto 'http://www.google.com/ncr'

# Go to sign in page and wait for credentials
#b.link(:id, 'gb_70').click
#b.text_field(:name, 'q').wait_until_present

#if ARGV[0] == '-f' and ARGV[1] then read in dorkfile
#toggle signin requrement

# Do the search
b.text_field(:name, 'q').set ARGV[0]
b.button(:name, 'btnG').click

# Harvest links
b.div(:id, 'resultStats').wait_until_present
b.h3s(:class, 'r').each do |h3|
    link = h3.link.href
    if link !~ /http(?:s)?:\/\/(?:www\.)?google.com/
        print link + "\n"
    end
end

# Wait a bit to throw off bot detection
sleep rand(1..5)

# Click next
b.link(:id, 'pnnext').click
#we should loop as long as pnnext is present

loop do
    #stuff
    break unless condition
end

