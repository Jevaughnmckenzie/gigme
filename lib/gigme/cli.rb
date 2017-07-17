class Gigme::CLI

  attr_accessor :location, :category

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
    elsif index.to_i > 0
      array[index]
    else
      false
  end

  def call
    puts "Welcome to Gigme - New York!"
    show_locations
  end

  def show_locations
    puts "Loading boroughs"

    locations = LocationLoader.new.load

    pretty_print(locations)
    ask_for_location(locations)
  end

  def ask_for_location(locations)
    puts
    puts "Where would you like to search for gigs?"
    puts "Type 'exit' to exit the program"
    puts

    if selection_response(locations)
      self.location = selection_response(locations)
      show_gig_categories(self.location)
    else
      puts "Not sure what you meant. Please choose a number associated with a location or 'exit' to quit the program."
      show_locations
    end

  end

  def show_gig_categories(input)
    puts
    puts "Here's list of gig categories:"
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

    if selection_response(categories)
      self.category = selection_response(categories)
      show_gigs(self.category)
    else
      puts "Not sure what you meant. Please choose a number associated with a gig, 'locations' to change location, or 'exit' to quit the program."
      show_gig_categories(self.location)
    end
  end

  def show_gigs(input)
    puts
    puts "Here's the most recent gigs according to your preferences"
    puts "Select the gig's number to get more details, \ntype 'categories' to choose from other gig categories,\ntype 'locations' to select a new location,\nor type 'exit' to quit."
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
      show_gig_categories(self.category_input)
    elsif gig_input == 'locations'
      show_locations
    elsif gig_input == 'exit'
      puts "Goodbye!"
      exit
    elsif gig_input.to_i > 0
      show_detail
    else
      puts "Not sure what you meant. Please choose from our list of gigs or enter 'locations', 'categories', or 'exit'."
      show_gigs(input)
    end
  end

  def show_detail
    puts "..........."
    puts "gig details"
    puts "..........."
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
