require 'spec_helper'

RSpec.describe LinkedListNode do
  describe '#initialize' do
    it 'can be initialized without a pointer' do
      node = described_class.new(21)
      expect(node.value).to eq(21)
      expect(node.next_node).to be_nil
    end

    it 'can be initialized with a pointer' do
      node_a = described_class.new(21)
      node_b = described_class.new(12, node_a)

      expect(node_b.value).to eq(12)
      expect(node_b.next_node).to eq(node_a)
    end
  end

  describe '#reverse' do
    context 'without mutation' do
      it 'reverse the node list using a Stack' do
        allow(Stack).to receive(:new).and_call_original

        node = described_class.new(37)
        node = described_class.new(99, node)
        node = described_class.new(12, node)
        node = described_class.new(32, node)

        expect(node.to_s).to eq("32 -> 12 -> 99 -> 37 -> nil")
        new_node = node.reverse(false)
        expect(new_node.to_s).to eq("37 -> 99 -> 12 -> 32 -> nil")
      end
    end

    context 'with mutation' do
      it 'reverse the node list without using a Stack' do
        expect(Stack).to_not receive(:new)

        node = described_class.new(37)
        node = described_class.new(99, node)
        node = described_class.new(12, node)
        node = described_class.new(32, node)

        expect(node.to_s).to eq("32 -> 12 -> 99 -> 37 -> nil")
        new_node = node.reverse(true)
        expect(new_node.to_s).to eq("37 -> 99 -> 12 -> 32 -> nil")
      end
    end
  end

  describe '#to_s' do
    context 'without a next node' do
      it 'return the node value -> nil' do
        node = described_class.new(21)
        expect(node.to_s).to eq("21 -> nil")
      end
    end

    context 'with a next node' do
      it 'return the node value -> next node' do
        node_a = described_class.new(21)
        node_b = described_class.new(15, node_a)

        expect(node_b.to_s).to eq("15 -> #{node_a.to_s}")
      end
    end

    context 'with a looped linked list' do
      it 'detect it and raise error' do
        node1 = described_class.new(37)
        node2 = described_class.new(99, node1)
        node3 = described_class.new(12, node2)
        node1.next_node = node3

        expect { node3.to_s }.to raise_error(StandardError, 'The list is infinite!')
      end
    end
  end
end
