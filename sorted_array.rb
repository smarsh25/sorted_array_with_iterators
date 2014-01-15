class SortedArray
  attr_reader :internal_arr

  def initialize arr=[]
    @internal_arr = []
    arr.each { |el| add el }
  end

  def add el
    # we are going to keep this array
    # sorted at all times. so this is ez
    lo = 0
    hi = @internal_arr.size
    # note that when the array just
    # starts out, it's zero size, so
    # we don't do anything in the while
    # otherwise this loop determines
    # the position in the array, *before*
    # which to insert our element
    while lo < hi
      # let's get the midpoint
      mid = (lo + hi) / 2
      if @internal_arr[mid] < el
        # if the middle element is less 
        # than the current element
        # let's increment the lo by one
        # from the current midway point
        lo = mid + 1
      else
        # otherwise the hi *is* the midway 
        # point, we'll take the left side next
        hi = mid 
      end
    end

    # insert at the lo position
    @internal_arr.insert(lo, el)
  end

  # 'each' Method executes block on each element of the array
  # and does not modify the original array
  def each &block
    i = 0
    while i < @internal_arr.size
      yield @internal_arr[i]    # or could have done, block.call @internal_arr[i]
      i += 1
    end
    return @internal_arr
  end

  # 'map' Method creates and returns a new array containing elements, 
  # with block applied to each
  def map &block
    # create a new array to return map applies block to 
    # each element, but returns that in a new array
    new_array = []
    each { |x| new_array.push yield x } if block_given?
    return new_array
  end

  def map! &block
    i = 0
      while i < @internal_arr.size
        # yield @internal_arr[i]    # or could have done, block.call @internal_arr[i]
        @internal_arr[i] = block.call(@internal_arr[i])
        i += 1
      end
      return @internal_arr 
    end

  def find value
    raise NotImplementedError.new("You need to implement the find method!")
  end

  def inject acc=nil, &block
    raise NotImplementedError.new("You need to implement the inject method!")
  end
end

#
#  1. implement each_with_index
#  2. then go back and refactor the previous methods with each_with_index
#

