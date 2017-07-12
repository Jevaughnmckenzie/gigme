class Gigme::Gig

  attr_accessor :title, :description, :compensation, :date_posted, :url, :details_page

  @@all = []

  def initialize(title:,date_posted:, url:)
    @title = title
    # @description = description
    # @compensation = compensation
    @date_posted = date_posted
    @url = url
    # @location = location
    @@all << self
  end

  def self.all
    @@all
  end

  def get_details
    self.details_page ||= Nokogiri::HTML(open(self.url))
  end

    # test code
    # gig_details_page = Nokogiri::HTML(open(BASE_PATH + gig_path))

    # *********** gig title code ***********

    # gig_title = gig_details_page.css(".postingtitletext #titletextonly").text

  def description
    # *********** gig description code ***********
    gig_description = gig_details_page.css("#postingbody").text
    # Remove any irrelavant text
    gig_description_text_array = gig_description.split(/\n/)
    end_of_irrelevant_text = gig_description_text_array.index("            QR Code Link to This Post")

    relevant_gig_text = gig_description_text_array[(end_of_irrelevant_text + 1)..(gig_description_text_array.count-1)].join
    self.description ||= relevant_gig_text.strip
  end
    # *********** gig compensation code ***********
  def compensation
    self.compensation ||= gig_details_page.css(".attrgroup span").text
  end

    # puts gig_title
    # puts
    # puts final_gig_description
    # puts
    # puts compensation
    # puts

end
