require './lib/linked_list_node'

class Stack
  attr_reader :head, :size

  def initialize
    @head = nil
    @size = 0
  end

  def push(element)
    @head = LinkedListNode.new(element, head)
    @size += 1
  end

  def pop
    raise StandardError.new("The stack is empty!") if @size == 0

    value = head.value
    @head = head.next_node
    @size -= 1
    value
  end
end
