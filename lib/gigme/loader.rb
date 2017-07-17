class Loader

  BASE_PATH = "https://newyork.craigslist.org"

  def load(path="")
    Nokogiri::HTML(open(BASE_PATH + path))
  end

end
