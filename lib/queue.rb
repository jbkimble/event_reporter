require 'csv'
require 'erb'
require 'json'
require 'nokogiri'
require 'yaml'
require 'open-uri'

class Que
  attr_accessor :final_queue

  def initialize
    @final_queue = []
  end

  def <<(arg)
    @final_queue << arg
  end

  def count
    @final_queue.count
  end

  def clear
    @final_queue = []
  end

  def print_q(q=@final_queue)
      puts "_" * 165
      puts "LAST NAME".ljust(12, " ") + "FIRST NAME".ljust(15, " ") + "EMAIL".ljust(37, " ") + "ZIPCODE".ljust(10, " ") + "CITY".ljust(20, " ") +
      "STATE".ljust(10, " ") + "ADDRESS".ljust(30, " ") + "PHONE".ljust(20, " ") + "DISTRICT".ljust(20, " ")

      puts "-" * 165
      q.each do |attendee|
        attendee.street = "" if attendee.street == nil || attendee.street == ""
        attendee.last_name = "" if attendee.last_name == nil || attendee.last_name == ""
        attendee.first_name = "" if attendee.first_name == nil || attendee.first_name == ""
        attendee.email_address = "" if attendee.email_address == nil || attendee.email_address == ""
        attendee.zipcode = "" if attendee.zipcode == nil || attendee.zipcode == ""
        attendee.city = "" if attendee.city == nil || attendee.city == ""
        attendee.state = "" if attendee.state == nil || attendee.state == ""
        attendee.home_phone = "" if attendee.home_phone == nil || attendee.home_phone == ""
        attendee.district = "" if attendee.district == nil || attendee.district == ""

        puts "#{attendee.last_name.ljust(12, " ")} #{attendee.first_name.ljust(15, " ")} #{attendee.email_address.ljust(35, " ")} #{attendee.zipcode.ljust(10, " ")}#{attendee.city.ljust(20, " ")}#{attendee.state.ljust(10, " ")}#{attendee.street.ljust(30, " ")} #{attendee.home_phone.ljust(20, " ")} #{attendee.district.ljust(20, " ")}"
      end
      puts "_" * 165
  end

  def print_sorted_by_attribute(attribute)
    case attribute
    when ("first_name")
      sorted_queue = @final_queue.sort_by &:first_name
    when "last_name"
      sorted_queue = @final_queue.sort_by &:last_name
    when "email_address"
      sorted_queue = @final_queue.sort_by &:email_address
    when "zipcode"
      sorted_queue = @final_queue.sort_by &:zipcode
    when "city"
      sorted_queue = @final_queue.sort_by &:city
    when "state"
      sorted_queue = @final_queue.sort_by &:state
    when "street"
      sorted_queue = @final_queue.sort_by &:street
    when "home_phone"
      sorted_queue = @final_queue.sort_by &:home_phone
    when "zipcode"
      sorted_queue = @final_queue.sort_by &:zipcode
    end
    print_q(sorted_queue)
  end

  def save_to_csv(file_name)
    @csv_prepped = @final_queue.map do |object|
      [object.last_name, object.first_name, object.email_address, object.zipcode, object.city, object.state, object.street, object.home_phone]
    end

    CSV.open(file_name, "w") do |csv|
      csv << ["Last_Name", "First_Name", "Email_Address", "Zipcode", "City", "State", "Home_Address", "Home_Phone"]
      @csv_prepped.each do |line|
        csv << line
      end
    end
  end

# saves to tab deliminated values
  def save_to_txt(file_name)
    tab_file_header = "Last_Name \t First_Name \t Email_Address \t Zipcode \t City \t State \t Home_Address \t Home_Phone \t District \n"

    txt_tab_prepped = @final_queue.map do |object|
      "#{object.last_name}\t#{object.first_name}\t#{object.email_address}\t#{object.zipcode}\t#{object.city}\t#{object.state}\t#{object.street}\t#{object.home_phone}\t#{object.district}\n"
    end

    File.open(file_name, 'w') do |file|
      txt_tab_prepped.unshift(tab_file_header)
      file.puts txt_tab_prepped
    end
  end

# save to valid parsable json
  def save_to_json(file_name)
    json_prepped = @final_queue.map do |object|
      {"first name" => object.first_name, "last_name" => object.last_name,
       "email" => object.email_address, "zipcode" => object.zipcode,
       "city" => object.city, "state" => object.state, "street" => object.street,
       "phone" => object.home_phone, "district" => object.district}
    end

    File.open(file_name, 'w') do |file|
      file.write JSON.pretty_generate(json_prepped)
    end
  end

#generates valid parsable XML
  def save_to_xml(file_name)
    build_xml = Nokogiri::XML::Builder.new do |xml|
      xml.root {
        xml.attendees {
          @final_queue.each do |attendee|
            xml.attendee {
              xml.first_name attendee.first_name
              xml.last_name attendee.last_name
              xml.email_address attendee.email_address
              xml.zipcode attendee.zipcode
              xml.city attendee.city
              xml.state attendee.state
              xml.street attendee.street
              xml.home_phone attendee.home_phone
              xml.district attendee.district
            }
          end
        }
      }
    end

    File.open(file_name, 'w') do |file|
      file.write build_xml.to_xml
    end
  end

#generates valid Yaml
  def save_to_yaml(file_name)
    json_prepped = @final_queue.map do |object|
      {"first name" => object.first_name, "last_name" => object.last_name,
       "email" => object.email_address, "zipcode" => object.zipcode,
       "city" => object.city, "state" => object.state, "street" => object.street,
       "phone" => object.home_phone, "district" => object.district}
    end

    File.open(file_name, 'w') do |file|
      file.write json_prepped.to_yaml
    end
  end

  def export_queue_to_html(file_name)
    @csv_prepped = @final_queue.map do |object|
      [object.last_name, object.first_name, object.email_address, object.zipcode, object.city, object.state, object.street, object.home_phone, object.district]
    end

    template_letter = File.read "html_form.erb"
    erb_template = ERB.new template_letter
    form_letter = erb_template.result(binding)

    File.open(file_name, 'w') do |file|
      file.puts form_letter
    end
  end

  def queue_district
    if @final_queue.length < 10
      @final_queue.each do |person|
        url = "https://congress.api.sunlightfoundation.com/districts/locate?zip=#{person.zipcode}&apikey=f3b65a9dbd784c7396537f91de1eaf53"
        all_district_info = JSON.parse(open(url).read)
        person.district = all_district_info["results"][0]["district"].to_s
      end
    else
      puts "Sorry there are 10 or more items in the queue, I am not allowed to contact the API"
    end
  end
end
