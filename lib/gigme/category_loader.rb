class CategoryLoader < Loader

  attr_accessor :location

  def initialize(location)
    @location = location
  end

  def load
    # ["computer", "labor", "creative", "events"]
    location_page = super(location[:href])
    gigs_results_html = location_page.css(".jobs div#ggg ul a")

    gigs_results_html.map do |gig_category|
      {
        name: gig_category.children.text,
        href: gig_category.attr("href")
      }

    end
  end

end
