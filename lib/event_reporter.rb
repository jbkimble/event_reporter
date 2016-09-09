require 'csv'
require 'pry'
require './lib/attendee'
require_relative 'queue'

class EventReporter
  attr_reader :queue, :all_attendees
  def initialize
    @queue = Que.new
    @all_attendees = []
  end

  def load_file(file_name="full_event_attendees.csv")
    CSV.foreach(file_name, headers: true, header_converters: :symbol) do |row|
      @all_attendees << Attendee.new(row)
    end
  end

  def finds_attribute_type(attribute_type, criteria)
    @queue.final_queue.clear
    @all_attendees.each do |object|
      if criteria == object.send(attribute_type)
      @queue << object
      end
    end
  end
end
