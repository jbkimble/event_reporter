#add to a runner file within a while loop that continues to run this program
#and create queue and event reporter objects until the user enters the exit command

#put inside a while loop (the type that executes once no matter what)
  puts "Welcome to Event Reporter, please enter a command:"
  user_command = gets.chomp.split
  #execute_user_input(user_command)
  temp_queue = []

  er_ob = EventReporter.new
  er_ob.load_file

  if user_command[0] = "find"
    then user_command[1]
  end
def execute_user_input(user_command)
end
