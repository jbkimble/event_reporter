require 'csv'
require 'pry'

class EventReporter
  def initialize
    @queue = Queue.new
  end

  def load_file(file_name="event_attendees.csv")
  #breaks down csv file into an array of hashes
    @csv_split = Array.new
    @contents = CSV.open(file_name, headers: true, header_converters: :symbol)
    @contents.map do |row|
      # @csv_split << row.to_h
      Attendee.new(row)
    end
    @csv_split
  end

  def finds_attribute_type(attribute_type, criteria)
    attribute_type = attribute_type.to_sym
    clean_data(attribute_type)

    @csv_split.each do |hash|
      if criteria == hash[attribute_type]
        @queue << hash

      end
    end
  end

  def clean_data(attribute_type)
    if attribute_type == (:first_name || :last_name)
      @csv_split.each do |hash|
        hash[attribute_type] = clean_name(hash[attribute_type])
      end
    elsif attribute_type == :zipcode
      @csv_split.each do |hash|
        hash[attribute_type] = clean_zipcode(hash[attribute_type])
      end
    elsif attribute_type == :homephone
      @csv_split.each do |hash|
        hash[attribute_type] = clean_phone_number(hash[attribute_type])
      end
    end
  end

  def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  def clean_name(name)
    name.strip.split.map{|word| word.capitalize}.join(' ')
  end

#add rjust to make all zeros
  def clean_phone_number(phonenumber)
    phonenumber.delete(' ()-.E').ljust(10, "0")
  end

  def load_the_queue
  end
end

# t = EventReporter.new
# t.load_file
# t.finds_attribute_type("homephone", "9820000000")
#t.finds_attribute_type("zipcode", "07306")
#binding.pry


class Queue
  attr_reader :final_queue
  def initialize
    @final_queue = []
  end

  def <<(arg)
    @final_queue << arg
  end

end
