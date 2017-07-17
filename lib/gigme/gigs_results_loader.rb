class GigsResultsLoader < Loader

  attr_accessor :category

  def initialize(category)
    @category = category
  end

  def load

    category_results = super(self.category[:href])
    gigs = category_results.css(".rows p.result-info")

    first_ten_gigs = gigs[0..9]

    first_ten_gigs.map do |gig|
      gig_text = gig.children.css("a").text
      #was having difficulty getting rid of newline characters and extra whitespace through gsub and similar means, so the following was my solution
      gig_text_char_array = gig_text.split(//)
      gig_text_end = gig_text_char_array.index("\n")
      relevant_gig_text = gig_text_char_array[0...gig_text_end].join
      # binding.pry
      {
        name: relevant_gig_text,
        href: gig.children.css("a").attr("href").value
      }

    end

  end

end
