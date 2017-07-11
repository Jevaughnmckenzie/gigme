class Gigme::Scraper

  BASE_PATH = "https://newyork.craigslist.org"
  @@homepage = Nokogiri::HTML(open(BASE_PATH))

  def self.locations
    location_fullname = 1
    self.locations_html = self.homepage.css("ul.sublinks li a").each_with_index { |location, index| puts "#{index + 1}. #{location.values[location_fullname]}"}
  end

  def self.homepage
    @@homepage
  end

  def self.locations_html=(html)
    @@locations_html = html
  end

  def self.locations_html
    @@locations_html
  end

  def self.gig_categories_for_location(location_index)
    location_path = self.locations_html[location_index - 1].attr("href")
    @@location_page = Nokogiri::HTML(open(BASE_PATH + location_path))
    @@location_page.css(".jobs div#ggg ul span.txt").each_with_index { |gig_category, index| puts "#{index + 1}. #{gig_category.children.text}"}
  end
end
