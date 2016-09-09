require './lib/event_reporter'
require './lib/help'

er_ob = EventReporter.new
puts  "\u{1F4D6}   Welcome to Event Reporter  \u{1F4D6}"

user_command = ""

until user_command[0] == "quit"
  puts "Please enter a command:"
  user_command = gets.chomp.split(" ")
  case user_command[0]
  when "load"
    if user_command[1] == nil
      er_ob.load_file
    else
      er_ob.load_file(user_command[1])
    end
  when "queue"
    if user_command[1] == "count"
      puts er_ob.queue.final_queue.count
    elsif user_command[1] == "clear"
      er_ob.queue.clear
    elsif user_command[1] == "district"
      er_ob.queue.queue_district
    elsif user_command[1] == "print"
        if user_command[2] == nil
          er_ob.queue.print_q
        else
        er_ob.queue.print_sorted_by_attribute(user_command[3])
        end
    elsif user_command[1] == "save"
        er_ob.queue.save_to_csv(user_command[3])
    elsif user_command[1] == "export"
      er_ob.queue.export_queue_to_html(user_command[3])
    end
  when "find"
      er_ob.finds_attribute_type(user_command[1], user_command[2..-1].join(" "))
  when "quit"
  when "help"
    if user_command[1] == nil
      HelpDocumentation.list_of_commands
    elsif user_command[1] == "load"
      HelpDocumentation.load_help
    elsif user_command[2] == "count"
      HelpDocumentation.count_help
    elsif user_command[2] == "clear"
      HelpDocumentation.clear_help
    elsif user_command[2] == "district"
      HelpDocumentation.district_help
    elsif user_command[2] == "print"
      if user_command[3] == nil
        HelpDocumentation.print_help
      else
        HelpDocumentation.print_by_help
      end
    elsif user_command[2] == "save"
      HelpDocumentation.save_to_csv_help
    elsif user_command[2] == "export"
      HelpDocumentation.save_to_html_help
    elsif user_command[1] == "find"
      HelpDocumentation.find_attribute_help
    end
  else
    puts "That command doesn't exist, please try again."
  end
end

puts "You've exited, good bye  \u{1F44B}"
