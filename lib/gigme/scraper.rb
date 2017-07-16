class Gigme::Scraper



  BASE_PATH = "https://newyork.craigslist.org"
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

  # def self.

  def self.locations
    location_fullname = 1
    self.locations_html = self.homepage.css("ul.sublinks li a").each_with_index { |location, index| puts "#{index + 1}. #{location.values[location_fullname]}"}
  end


  def self.gig_categories_for_location(location_index)
    now = Time.now
    location_path = self.locations_html[location_index - 1].attr("href")
    puts "Took location_path #{Time.now - now}"
    now = Time.now
    location_page = Nokogiri::HTML(open(BASE_PATH + location_path))
    puts "Nokogiri took #{Time.now - now}"
    now = Time.now
    self.gigs_results_html = location_page.css(".jobs div#ggg ul a")
    puts "gigs_results_html took #{Time.now - now}"
    now = Time.now
    self.gigs_results_html.each_with_index { |gig_category, index| puts "#{index + 1}. #{gig_category.children.text}"}
    puts "gigs_results_html putsing took #{Time.now - now}"
  end
  # https://newyork.craigslist.org//search/mnh/crg
  # def self.xpath.gig_categories_for_location()
  # end

  def self.gigs_for_category(category_index)
    gigs_path = self.gigs_results_html[category_index - 1].attr("href")
    # binding.pry
    gigs_page = Nokogiri::HTML(open(BASE_PATH + gigs_path))
    # binding.pry
    self.gig_html = gigs_page.css(".rows p.result-info")

    first_ten_gigs = self.gig_html[0..9]
    # binding.pry
    first_ten_gigs.each_with_index do |gig, index|

    start_of_irrelevant_text = gig.children.css("a").text.split(//).index("\n")
      self.gig_info = {date_posted: gig.children.css("time").attr("datetime").value,
                  url: (BASE_PATH + gig.children.css("a").attr("href").value),
                  title: gig.children.css("a").text.split(//)[0...start_of_irrelevant_text].join}
      puts "#{gig_info[:date_posted]} #{gig_info[:title]}"
      # Gigme::Gig.new(gig_info)
    end
  end



end
