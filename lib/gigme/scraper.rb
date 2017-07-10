class Gigme::Scraper

  @@homepage = Nokogiri::HTML(open("https://newyork.craigslist.org/"))
  def self.locations
    location_fullname = 1
    self.homepage.css("ul.sublinks li a").each_with_index { |location, index| puts "#{index + 1}. #{location.values[1]}"}
  end

  def self.homepage
    @@homepage
  end

  
end
