class LinkedListNode
  attr_accessor :value, :next_node

  def initialize(value, next_node = nil)
    @value = value
    @next_node = next_node
  end

  def reverse(with_mutation = false)
    if with_mutation
      reverse_with_mutation
    else
      reverse_without_mutation
    end
  end

  def to_s
    raise StandardError.new("The list is infinite!") if looping?

    if next_node
      "#{value} -> #{next_node.to_s}"
    else
      "#{value} -> nil"
    end
  end

  private

  def looping?
    seen = []
    head = self

    while head.next_node do
      return true if seen.include?(head)
      seen << head
      head = head.next_node
    end

    false
  end

  def reverse_without_mutation
    stack = Stack.new
    head = self.freeze # Make sure we don't mutate the node

    while head
      stack.push(head.value)
      head = head.next_node
    end

    stack.head
  end

  def reverse_with_mutation
    return self if next_node.nil?

    head, previous, self.next_node = next_node, self, nil
    link = head.next_node

    while link
      head.next_node = previous
      previous = head
      head = link
      link = link.next_node
    end

    head.next_node = previous
    head
  end
end

