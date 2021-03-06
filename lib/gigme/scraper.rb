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

  def self.locations
    location_fullname = 1
    self.locations_html = self.homepage.css("ul.sublinks li a").each_with_index { |location, index| puts "#{index + 1}. #{location.values[location_fullname]}"}
  end


  def self.gig_categories_for_location(location_index)
    location_path = self.locations_html[location_index - 1].attr("href")
    location_page = Nokogiri::HTML(open(BASE_PATH + location_path))
    self.gigs_results_html = location_page.css(".jobs div#ggg ul a")
    self.gigs_results_html.each_with_index { |gig_category, index| puts "#{index + 1}. #{gig_category.children.text}"}
  end

  def self.gigs_for_category(category_index)
    gigs_path = self.gigs_results_html[category_index - 1].attr("href")
    gigs_page = Nokogiri::HTML(open(BASE_PATH + gigs_path))
    # binding.pry
    self.gig_html = gigs_page.css(".rows p.result-info")

    first_ten_gigs = self.gig_html[0..9]

    first_ten_gigs.each_with_index do |gig, index|
      gig_text = gig.children.css("a").text
      #was having difficulty getting rid of newline characters and extra whitespace through gsub and similar means, so the following was my solution
      gig_text_char_array = gig_text.split(//)
      gig_text_end = gig_text_char_array.index("\n")
      relevant_gig_text = gig_text_char_array[0..gig_text_end].join
      puts "#{index + 1}. #{relevant_gig_text} - Posted:  #{gig.children.css("time").attr("datetime").value}"

    end
  end

  def self.show_gig_details(gig_index)
    gig_path = self.gig_html[gig_index - 1].children.css("a").attr("href")
    gig_details_page = Nokogiri::HTML(open(BASE_PATH + gig_path))

    # test code
    # gig_details_page = Nokogiri::HTML(open(BASE_PATH + gig_path))

    # *********** gig title code ***********

    gig_title = gig_details_page.css(".postingtitletext #titletextonly").text

    # *********** gig description code ***********
    gig_description = gig_details_page.css("#postingbody").text
    # Remove any irrelavant text
    gig_description_text_array = gig_description.split(/\n/)
    end_of_irrelevant_text = gig_description_text_array.index("            QR Code Link to This Post")

    relevant_gig_text = gig_description_text_array[(end_of_irrelevant_text + 1)..(gig_description_text_array.count-1)].join
    final_gig_description = relevant_gig_text.strip

    # *********** gig compensation code ***********

    compensation = gig_details_page.css(".attrgroup span").text

    puts
    puts
    puts "----------------------------"
    puts gig_title
    puts
    puts final_gig_description
    puts
    puts compensation
    puts
  end
end
