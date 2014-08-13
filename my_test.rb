require 'nokogiri'
require 'open-uri'
  url = "http://sfbay.craigslist.org/sfc/pet/"
  doc = Nokogiri::HTML(open(url))
  rows = doc.css(".row")
  results = []
  rows.each do |row|
    test = row.css("a .hdrlnk").text
    puts test
    # date = row.css(".date").text
    # puts date
    # if date.match(date_str)  && date.match(date_str).length
    #   results.push(row)
    # end
end