class Gigme::CLI
  def call
    puts "Welcome to Gigme - New York!"
    show_locations
    ask_for_location
    show_gig_catagories
    ask_for_gig_catagory
    show_gigs
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
  end

  def ask_for_location
    puts
    puts "Where would you like to search for gigs?"
    input = gets.strip.to_i
  end

  def show_gig_catagories
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
  end

  def ask_for_gig_catagory
    puts
    puts "What kind of gig are you looking for?"
    input = gets.strip.to_i
  end

  def show_gigs
    puts "Here's the most recent gigs according to your preferences:"
  end
end
