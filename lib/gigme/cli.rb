class Gigme::CLI

  attr_accessor :locations_input, :category_input

  def call
    puts "Welcome to Gigme - New York!"
    show_locations
  end

  def show_locations
    puts "Please choose from our list of locations:"
    puts(<<-DOC.sub(/\n$/, ''))
      1. Mahattan
      2. Brooklyn
      3. Queens
      4. The Bronx
      5. Staten Island
      6. Long Island
      7. Westchester
    DOC
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
    elsif self.locations_input.to_i > 0
      show_gig_catagories(self.locations_input.to_i)
    else
      puts "Not sure what you meant. Please choose a number associated with a location or 'exit' to quit the program."
      show_locations
      ask_for_location
    end

  end

  def show_gig_catagories(input)
    puts
    puts "Here's list of gig catagories:"
    puts(<<-DOC.sub(/\n$/, ''))
      1. Computer
      2. Creative
      3. Crew
      4. Domestic
      5. Event
      6. Labor
      7. Talent
      8. Writing
    DOC
    ask_for_gig_catagory
  end

  def ask_for_gig_catagory
    puts
    puts "What kind of gig are you looking for?"
    self.category_input = gets.strip.to_i
    show_gigs(self.category_input)
  end

  def show_gigs(input)
    puts
    puts "Here's the most recent gigs according to your preferences"
    puts "Select the gig's number to get more details, \ntype 'categories' to choose from other gig catagories,\ntype 'locations' to select a new location,\nor type 'exit' to quit."
    puts(<<-DOC.sub(/\n$/, ''))
      1. gig
      2. gig
      3. gig
      4. gig
      5. gig
      6. gig
      7. gig
      8. gig
    DOC

    gig_input = gets.strip.downcase

    if gig_input == 'categories'
      show_gig_catagories(self.category_input)
    elsif gig_input == 'locations'
      show_locations
    elsif gig_input == 'exit'
      puts "Goodbye!"
      exit
    elsif gig_input.to_i > 0
      show_detail
    else
      puts "Not sure what you meant. Please choose from our list of gigs or enter 'locations', 'catagories', or 'exit'."
      show_gigs(input)
    end
  end

  def show_detail
    puts "..........."
    puts "gig details"
    puts "..........."
  end
end
