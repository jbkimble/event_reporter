require 'csv'
require 'pry'
require './lib/attendee'
require './lib/queue'

class EventReporter
  #attr_reader :queue
  def initialize
  end

  def load_file(file_name="event_attendees.csv")
    @all_attendees = []
    CSV.foreach(file_name, headers: true, header_converters: :symbol) do |row|
      @all_attendees << Attendee.new(row)
      #binding.pry
    end
    #@csv_split
  end

  def finds_attribute_type(attribute_type, criteria)
    @queue = Queue.new
    @all_attendees.each do |object|
      if criteria == object.send(attribute_type)
      @queue << object
      end
    end
      binding.pry
      x = @queue.count
  end
end

t = EventReporter.new
t.load_file
t.finds_attribute_type("first_name", "Sarah")

# t.load_the_queue

#t.finds_attribute_type("homephone", "9820000000")
#t.finds_attribute_type("zipcode", "07306")
binding.pry
@queue.count
