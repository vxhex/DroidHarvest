require 'watir'

b = Watir::Browser.new :chrome

for i in 1..296
    b.goto "http://kickass.to/android/#{i}/?field=seeders&sorder=desc"
    b.links.collect(&:href).each do |link|
        if link.start_with?('magnet')
            print "#{link}\n"
        end
    end
    sleep rand(1..5)
end
