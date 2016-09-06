require 'csv'
require 'pry'

class EventReporter
  attr_reader :queue
  def initialize
    @queue = []
  end

  def load_file(file_name="event_attendees.csv")
  #breaks down csv file into an array of hashes
    @csv_split = Array.new
    CSV.foreach(file_name, headers: true, header_converters: :symbol) do |row|
      @csv_split << row.to_h
    end
    @csv_split
  end

  def finds_attribute_type(attribute_type, criteria)
    attribute_type = attribute_type.to_sym
    clean_data(attribute_type)
    @csv_split.each do |hash|
      if criteria.capitalize.strip == hash[attribute_type]
        @queue << hash
        binding.pry
      end
      load_the_queue(@queue)
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
    loaded_queue = Queue.new(@queue)
  end
end

# t = EventReporter.new
# t.load_file
# t.finds_attribute_type("first_name", "shiyu ")


#t.finds_attribute_type("homephone", "9820000000")
#t.finds_attribute_type("zipcode", "07306")
#binding.pry








# require 'csv'
# require 'pry'
#
# class EventReporter
#   def initialize
#     @queue = []
#   end
#
#   def load_file(file_name="event_attendees.csv")
#   #breaks down csv file into an array of hashes
#     @csv_split = Array.new
#     CSV.foreach(file_name, headers: true, header_converters: :symbol) do |row|
#       @csv_split << row.to_h
#     end
#   end
#
#   def finds_attribute_type(attribute_type, criteria)
#     attribute_type = attribute_type.to_sym
#     clean_data(attribute_type)
#
#     @csv_split.each do |hash|
#       if criteria == hash[attribute_type]
#         @queue << hash
#       end
#     end
#     binding.pry
#   end
#
#   def clean_data(attribute_type)
#     if attribute_type == (:first_name || :last_name)
#       @csv_split.each do |hash|
#         hash[attribute_type] = clean_name(hash[attribute_type])
#       end
#     elsif attribute_type == :zipcode
#       @csv_split.each do |hash|
#         hash[attribute_type] = clean_zipcode(hash[attribute_type])
#       end
#     elsif attribute_type == :homephone
#       @csv_split.each do |hash|
#         hash[attribute_type] = clean_phone_number(hash[attribute_type])
#       end
#     end
#   end
#
#   def clean_zipcode(zipcode)
#     zipcode.to_s.rjust(5,"0")[0..4]
#   end
#
#   def clean_name(name)
#     name.strip.split.map{|word| word.capitalize}.join(' ')
#   end
#
# #add rjust to make all zeros
#   def clean_phone_number(phonenumber)
#     phonenumber.delete(' ()-.E').ljust(10, "0")
#   end
#
#   def load_the_queue
#   end
# end
#
# t = EventReporter.new
# t.load_file
# t.finds_attribute_type("homephone", "9820000000")
# #t.finds_attribute_type("zipcode", "07306")
# #binding.pry
