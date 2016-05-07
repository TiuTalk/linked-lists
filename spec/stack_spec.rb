require 'spec_helper'

RSpec.describe Stack do
  subject(:stack) { described_class.new }

  describe '#initialize' do
    it 'is initialized with a nil head and 0 size' do
      expect(stack.head).to be_nil
      expect(stack.size).to be_zero
    end
  end

  describe '#push' do
    it 'change the head of the stack' do
      expect(stack.head).to be_nil

      stack.push(12)

      expect(stack.head).to be_a(LinkedListNode)
      expect(stack.head.value).to eq(12)
      expect(stack.head.next_node).to be_nil

      stack.push(15)

      expect(stack.head).to be_a(LinkedListNode)
      expect(stack.head.value).to eq(15)
      expect(stack.head.next_node.value).to eq(12)
    end

    it 'change the size of the stack' do
      expect { stack.push(12) }.to change(stack, :size).to(1)
      expect { stack.push(15) }.to change(stack, :size).to(2)
    end
  end

  describe '#pop' do
    context 'with empty stack' do
      it 'raise error' do
        expect { stack.pop }.to raise_error(StandardError, 'The stack is empty!')
      end
    end

    context 'with stack containing one element' do
      before { stack.push(12) }

      it 'return the removed element' do
        expect(stack.pop).to eq(12)
      end

      it 'change the stack head' do
        expect { stack.pop }.to change(stack, :head).to(nil)
      end

      it 'change the stack size' do
        expect { stack.pop }.to change(stack, :size).to(0)
      end
    end

    context 'with stack containing multiple elements' do
      before { stack.push(12); stack.push(15) }

      it 'return the removed element' do
        expect(stack.pop).to eq(15)
        expect(stack.pop).to eq(12)
      end

      it 'change the stack head' do
        expect(stack.head.value).to eq(15)
        stack.pop
        expect(stack.head.value).to eq(12)
        stack.pop
        expect(stack.head).to be_nil
      end

      it 'change the stack size' do
        expect { stack.pop }.to change(stack, :size).to(1)
        expect { stack.pop }.to change(stack, :size).to(0)
      end
    end
  end
end
