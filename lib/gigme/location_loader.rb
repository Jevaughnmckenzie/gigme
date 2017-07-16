require "pry"

class LocationLoader < Loader


  def load
    # ["manhatten", "brooklyn", "queens", "the bronx"]
    homepage = super
    locations_html = homepage.css("ul.sublinks li a")
    locations_html.map do |location|
      {
        name: location.values[1],
        href: location.attr("href")
      }
    end
    # binding.pry
  end
end
