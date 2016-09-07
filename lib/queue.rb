require 'pry'

class Queue
  attr_reader :final_queue
  def initialize
    @final_queue = []
    binding.pry
  end

  def <<(arg)
    @final_queue << arg
  end

  def count
    @final_queue.count
  end

end


# class Queue
#   attr_reader :final_queue
#
#   def initialize(queue)
#     @final_queue = queue
#     binding.pry
#   end
#
# end
