class Gigme::Gig

  attr_accessor :title, :description, :compensation, :date_posted, :url

  def initialize(title:,description:,compensation:,date_posted:, url:)
    @title = title
    @description = description
    @compensation = compensation
    @date_posted = date_posted
    # @location = location
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

    Gigme::Gig.new( title: gig_title,
                    description: gig_description,
                    compensation: compensation)

    # puts gig_title
    # puts
    # puts final_gig_description
    # puts
    # puts compensation
    # puts
  end

end
