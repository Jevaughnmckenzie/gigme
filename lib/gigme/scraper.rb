class Gigme::Scraper

  BASE_PATH = "https://newyork.craigslist.org/brk/"
  @@homepage = Nokogiri::HTML(open(BASE_PATH))

  def self.homepage
    @@homepage
  end

  def self.locations_html=(html)
    @@locations_html = html
  end

  def self.locations_html
    @@locations_html
  end

  def self.gigs_results_html=(html)
    @@gigs_results_html = html
  end

  def self.gigs_results_html
    @@gigs_results_html
  end

  def self.gig_html=(html)
    @@gig_html = html
  end

  def self.gig_html
    @@gig_html
  end

  def self.locations
    location_fullname = 1
    self.locations_html = self.homepage.css("ul.sublinks li a").each_with_index { |location, index| puts "#{index + 1}. #{location.values[location_fullname]}"}
  end


  def self.gig_categories_for_location
    location_path = self.locations_html[location_index - 1].attr("href")
    location_page = Nokogiri::HTML(open(BASE_PATH))
    self.gigs_results_html = location_page.css(".jobs div#ggg ul a")
    self.gigs_results_html.each_with_index { |gig_category, index| puts "#{index + 1}. #{gig_category.children.text}"}
  end

  def self.gigs_for_category(category_index)
    gigs_path = self.gigs_results_html[category_index - 1].attr("href")
    gigs_page = Nokogiri::HTML(open(BASE_PATH + gigs_path))
    binding.pry
    self.gig_html = gigs_page.css(".rows p.result-info")

    first_ten_gigs = self.gig_html[0..9]

    first_ten_gigs.each_with_index do |gig, index|
      puts "#{gig.children.css("time").attr("datetime").value} #{gig.children.css("a").text}"

    end
  end
end
