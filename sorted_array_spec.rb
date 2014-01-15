require 'rspec'
require './sorted_array.rb'

shared_examples "yield to all elements in sorted array" do |method|
    specify do 
      expect do |b| 
        sorted_array.send(method, &b) 
      end.to yield_successive_args(2,3,4,7,9) 
    end
end

describe SortedArray do
  let(:source) { [2,3,4,7,9] }
  let(:sorted_array) { SortedArray.new source }

  describe "iterators" do
    describe "that don't update the original array" do 
      describe :each do
        context 'when passed a block' do
          it_should_behave_like "yield to all elements in sorted array", :each
        end

        it 'should return the array' do
          sorted_array.each {|el| el }.should eq source
        end
      end

      describe :map do
        it 'the original array should not be changed' do
          original_array = sorted_array.internal_arr
          expect { sorted_array.map {|el| el } }.to_not change { original_array }
        end

        it_should_behave_like "yield to all elements in sorted array", :map

        it 'creates a new array containing the values returned by the block' do
          sorted_array.map {|ele| ele * 2}.should == source.map {|ele| ele * 2}
        end
      end
    end

    describe "that update the original array" do
      describe :map! do
        it 'the original array should be updated' do
          # original_array = sorted_array.internal_arr
          # expect { sorted_array.map {|el| el } }.to change { original_array }
          sorted_array.map! {|ele| ele * 2}.should_not == [2,3,4,7,9]
    
        end

        it_should_behave_like "yield to all elements in sorted array", :map!

        it 'should replace value of each element with the value returned by block' do
          sorted_array.map! {|ele| ele * 2}.should == [4,6,8,14,18]
        end
      end
    end
  end

  describe :find do
    it_should_behave_like "yield to all elements in sorted array", :find

    it "should find an element and return true" do
      sorted_array.find {|ele| ele == 7}.should == 7
    end
    it "should not find an element and return nil" do
      sorted_array.find {|ele| ele == 1007}.should == nil
    end
  end


# block_with_two_args = Proc.new ({ |acc, val| acc + val })
# send(inject, block_with_two_args)

    # specify do 
    # # let(:source) { [2,3,4,7,9] }
    #   expect do |b|
    #     block_with_two_args = Proc.new { |acc, val| return true} 
    #     sorted_array.send(method, block_with_two_args) 
    #   end.to yield_successive_args([0,2], [2,3] [5,4], [9,7], [16,9]) 
    # end


  describe :inject do
    it_should_behave_like "yield to all elements in sorted array", :inject

    it "does not currently have any examples for it" do
      pending "define some examples by looking up http://www.ruby-doc.org/core-2.1.0/Enumerable.html#method-i-inject"
    end
  end
end
