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

  # 'map!' Method applies block to each element of the array, 
  # modifying self
  def map! &block
    # create a new array to store results of block applied to 
    # each element
    new_array = []
    each { |x| new_array.push yield x }
    #update internal array with new elements
    @internal_arr.replace(new_array)
    return @internal_arr 
  end

  # find the object in an array, where the block evaluates to true
  # returns nil if not found
  def find &block
    # assume not found
    result = nil
    # iterate over each element, evaluate block
    each do |x|
      if yield x      # if evaluates true, break and return that object
        result = x
        break
      end
    end
    return result
  end
#optimized version
# def find value
# @internal_arr.each do |x|
#   return x if yield x
# end


  def inject acc=nil, &block
    raise NotImplementedError.new("You need to implement the inject method!")
  end
# def 
  # @internal_arr.each do |x|
    # acc = yield acc, x
# end
 
end

#
#  1. implement each_with_index
#  2. then go back and refactor the previous methods with each_with_index
#

# def print_array(arr)
#   arr.each {|x| print "#{x} "}
#   puts
# end


# arr = SortedArray.new([2,3,4,7,9])
# print_array(arr)
# arr2 = arr.map {|x| x * 2}
# print_array(arr)
# print_array(arr2)
# arr.map! {|x| x * 2}
# print_array(arr)
