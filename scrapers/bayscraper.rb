require 'watir'

b = Watir::Browser.new :chrome
b.goto 'http://thepiratebay.se/browse/408/0/7/0'

while b.image(:src, '/static/img/next.gif').exists?
    b.links.collect(&:href).each do |link|
        if link.start_with?('magnet')
            print "#{link}\n"
        end
    end
    sleep rand(1..3)
    b.image(:src, '/static/img/next.gif').click()
end
