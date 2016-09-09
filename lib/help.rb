class HelpDocumentation
  def self.list_of_commands
    puts "\t  ________________________________________________________________
          ================================================================
          ||  Available commands: help <command>, load <filename>,      ||
          ||   find <attribute> <criteria>, queue count, queue clear,   ||
          ||   queue district, queue print, queue print by <attribute>, ||
          ||   queue save to <filename.csv>,                            ||
          ||   queue export html <filename.html>, quit                     ||
          ================================================================
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          "
  end

  def self.load_help
    puts "\t ****Pass 'load' any file name and it will load the given CSV.****
          ****If no filename is given it will default to 'event_attendees.csv****'"
  end

  def self.count_help
    puts "****Outputs how many records are in the current queue****"
  end

  def self.clear_help
    puts "****Empties the current queue****"
  end

  def self.district_help
    puts "****If there are less than 10 entries in the queue, this command will
          use the Sunlight API to get Congressional District information for each
          entry.****"
  end

  def self.print_help
    puts "****Prints out the current queue****"
  end

  def self.print_by_help
    puts "****Prints the data sorted by the specific data type passed to it.****"
  end

  def self.save_to_csv_help
    puts "****Exports the current queue to CSV****"
  end

  def self.save_to_html_help
    puts "****Exports the current queue to a HTML table****"
  end

  def self.find_attribute_help
    puts "\t****Loads the queue with all records matching the criteria for a given attribute.
          Examples: 'find zipcode 20011' 'find last_name Johnson' 'find state VA'****"
  end
end
