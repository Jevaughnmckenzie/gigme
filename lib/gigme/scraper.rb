class Gigme::Scraper

  @@homepage = Nokogiri::HTML(open("https://newyork.craigslist.org/"))
  def locations

  end

  def self.homepage
    @@homepage
  end
end
