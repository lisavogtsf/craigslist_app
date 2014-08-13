# scrapper.rb
require 'nokogiri'
require 'open-uri'
require 'pry'

def filter_links(rows, regex)
  # takes in rows and returns uses
  # regex to only return links 
  # that have "pup", "puppy", or "dog"
  # keywords
  filtered = []
  counter = 0
  rows.each do |row|
    test_text = row.css("a.hdrlnk").text
    if test_text.match(regex)
      puts "dog text #{test_text}"
      path = row.css("a.hdrlnk").attribute("href")
      url = "http://sfbay.craigslist.org#{path}"
      filtered.push(url)
          # counter += 1
    end
  end
  puts filtered
  # puts counter
end

def get_todays_rows(doc, date_str)
  #  1.) open chrome console to look in inside p.row to see
  #  if there is some internal date related content
  #  2.) figure out the class that you'll need to select the
  #   date from a row

  # collect all rows
  rows = doc.css(".row")
  #iterate over all rows, comparing date
  results = []
  rows.each do |row|
    date = row.css(".date").text
    if date.match(date_str)  && date.match(date_str).length
      results.push(row)
    end
  end
    # these results will become the rows parameter
    return results
end

# This method returns page results for the url defined inside
# these results are parsed by Nokogiri
# saved in last line of method, therefore implicitly returned
def get_page_results
  url = "http://sfbay.craigslist.org/sfc/pet/"
  doc = Nokogiri::HTML(open(url))
end

# Calls get_page_results and get_todays_rows inside it
# need to get those working first
def search(date_str)
  doc = get_page_results
  rows = get_todays_rows(doc, date_str)
  # to get  the relevant links
  regex = /puppy|pup|Pup|dog|Dog/
  results = filter_links(rows, regex)
end

# want to learn more about 
# Time in ruby??
#   http://www.ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/Date.html#strftime-method
today = Time.now.strftime("%b %d")
search(today)