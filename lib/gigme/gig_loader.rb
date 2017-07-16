class GigLoader < Loader

  attr_accessor :gig_info

  def initialize(gig_info)
    @gig_info = gig_info
  end

  def load
    gig_details_page = super(self.gig_info)

    gig = Gig.new
    gig.title = gig_title = gig_details_page.css(".postingtitletext #titletextonly").text
    gig.description = extract_dsecription(gig_details_page)
    gig.compensation = compensation = gig_details_page.css(".attrgroup span").text

    gig
  end


  def extract_dsecription(html)
    gig_description = html.css("#postingbody").text
    # Remove any irrelavant text
    gig_description_text_array = gig_description.split(/\n/)
    end_of_irrelevant_text = gig_description_text_array.index("            QR Code Link to This Post")

    relevant_gig_text = gig_description_text_array[(end_of_irrelevant_text + 1)..(gig_description_text_array.count-1)].join
    relevant_gig_text.strip
  end


end
