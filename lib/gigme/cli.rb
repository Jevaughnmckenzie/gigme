class Gigme::CLI
  attr_accessor :locations_input, :category_input, :locations



  def call
    puts "Welcome to Gigme - New York!"
    show_locations
  end

  def show_locations
    puts "Please choose from our list of locations:"
    self.locations = Gigme::Scraper.locations
    ask_for_location
  end

  def ask_for_location
    puts
    puts "Where would you like to search for gigs?"
    puts "Type 'exit' to exit the program"
    puts
    self.locations_input = gets.strip.downcase

    if self.locations_input == 'exit'
      puts 'Goodbye!'
      exit
    elsif self.locations_input.to_i > 0 && self.locations_input.to_i <= self.locations.count
      show_gig_categories(self.locations_input.to_i)
    else
      puts "Not sure what you meant. Please choose a number associated with a location or 'exit' to quit the program."
      show_locations
    end

  end

  def show_gig_categories(input)
    puts
    puts "Here's list of gig categories:"
    Gigme::Scraper.gig_categories_for_location(input)
    # categories.each_with_index { |category, index| puts "#{index + 1}. #{category}" }

    ask_for_gig_category
  end

  def ask_for_gig_category
    puts
    puts "What kind of gig are you looking for?"
    self.category_input = gets.strip.downcase

    if self.category_input == 'exit'
      puts 'Goodbye!'
      exit
    elsif self.category_input == 'locations'
      show_locations
    elsif self.category_input.to_i > 0
      show_gigs(self.category_input.to_i)
    else
      puts "Not sure what you meant. Please choose a number associated with a gig, 'locations' to change location, or 'exit' to quit the program."
      show_gig_categories(self.category_input)
      ask_for_gig_category
    end
  end

  def show_gigs(input)
    puts
    puts "Here's the most recent gigs according to your preferences"
    puts
    puts "Select the gig's number to get more details.\nType 'categories' to choose from other gig categories,'locations' to select a new location, or type 'exit' to quit."
    Gigme::Scraper.gigs_for_category(input)
    Gigme::Gig.all.each_with_index { |gig, index| puts "#{index + 1}. #{gig.title}" }
    take_gigs_results_input
  end

  def take_gigs_results_input
    gig_input = gets.strip.downcase

    if gig_input == 'categories'
      show_gig_categories(self.category_input)
    elsif gig_input == 'locations'
      show_locations
    elsif gig_input == 'exit'
      puts "Goodbye!"
      exit
    elsif gig_input.to_i > 0
      show_detail(gig_input.to_i)
    else
      puts "Not sure what you meant. Please choose from our list of gigs or enter 'locations', 'categories', or 'exit'."
      show_gigs(input)
    end
  end

  def show_detail(gig_result_index)
    puts
    Gigme::Gig.all[gig_result_index - 1].title
    puts
    Gigme::Gig.all[gig_result_index - 1].description
    puts
    Gigme::Gig.all[gig_result_index - 1].compensation
    puts

    take_gig_details_input
  end

  def take_gig_details_input
    puts "What would you like to do next?"
    puts(<<-DOC.sub(/\n$/, ''))
      1. Back to results
      2. Back to categories
      3. Back to locations
      4. exit
    DOC
    input = gets.strip

    if input.to_i == 1
      show_gigs(self.category_input.to_i)
    elsif input.to_i == 2
      show_gig_categories(self.locations_input.to_i)
    elsif input.to_i == 3
      show_locations
    else
      puts "Goodbye!"
      exit
    end
  end
end
