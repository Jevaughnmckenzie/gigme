class Gigme::CLI

  attr_accessor :location, :category, :gig

  def pretty_print(array)
    array.each_with_index do |cell, i|
      puts "#{i+1}. #{cell[:name]}"
    end
  end

  def selection_response(array)
    input = gets.chomp.downcase
    index = input.to_i - 1

    if index == 'exit'
      puts 'Goodbye!'
      exit
    elsif index == 'locations'
      show_locations
    elsif index.to_i >= 0
      array[index]
    else
      false
    end
  end

  def call
    puts "Welcome to Gigme - New York!"
    show_locations
  end

  def show_locations
    puts "Loading boroughs"
    puts
    puts "Please choose from our list of locations:"
    locations = LocationLoader.new.load

    pretty_print(locations)
    ask_for_location(locations)
  end

  def ask_for_location(locations)
    puts
    puts "Where would you like to search for gigs?"
    puts "Type 'exit' to exit the program"
    puts

    self.location = selection_response(locations)

    if self.location
      # binding.pry
      show_gig_categories(self.location)
    else
      puts "Not sure what you meant. Please choose a number associated with a location or 'exit' to quit the program."
      show_locations
    end
  end

  def show_gig_categories(location)
    puts
    puts "Here's list of gig categories:"
    # categories.each_with_index { |category, index| puts "#{index + 1}. #{category}" }
    # puts(<<-DOC.sub(/\n$/, ''))
    #   1. Computer
    #   2. Creative
    #   3. Crew
    #   4. Domestic
    #   5. Event
    #   6. Labor
    #   7. Talent
    #   8. Writing
    # DOC


    categories = CategoryLoader.new(location).load

    pretty_print(categories)

    ask_for_gig_category(categories)
  end

  def ask_for_gig_category(categories)
    puts
    puts "What kind of gig are you looking for?"

    self.category = selection_response(categories)
    if self.category
      show_gigs(self.category)
    else
      puts "Not sure what you meant. Please choose a number associated with a gig, 'locations' to change location, or 'exit' to quit the program."
      show_gig_categories(self.location)
    end
  end

  def show_gigs(category)
    puts
    puts "Here's the most recent gigs according to your preferences"
    puts "Select the gig's number to get more details, \ntype 'categories' to choose from other gig categories,\ntype 'locations' to select a new location,\nor type 'exit' to quit."

    gigs = GigsResultsLoader.new(category).load
    binding.pry
    pretty_print(gigs)

    ask_for_gig_selection(gigs)

  end

  def ask_for_gig_selection(gigs)
    gig_input = gets.strip.downcase

    self.gig = selection_response(gigs)

    if gig_input == 'categories'
      show_gig_categories(self.location)
    elsif self.gig
      show_detail(self.gig)
    else
      puts "Not sure what you meant. Please choose from our list of gigs or enter 'locations', 'categories', or 'exit'."
      show_gigs(self.category)
    end
  end

  def show_detail(gig)
    gig_details = GigLoader.new(gig).load

    puts gig_details.title
    puts
    puts gig_details.description
    puts
    puts gig_details.compensation

    puts
    puts "What would you like to do next?"
    puts(<<-DOC.sub(/\n$/, ''))
      1. Back to results
      2. Back to categories
      3. Back to locations
      4. exit
    DOC
    input = gets.strip

    if input.to_i == 1
      show_gigs(self.category)
    elsif input.to_i == 2
      show_gig_categories(self.location)
    elsif input.to_i == 3
      show_locations
    else
      puts "Goodbye!"
      exit
    end
  end
end
