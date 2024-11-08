class MergeSort
  def merge_sort(array)
    if array.size <= 1
      return array
    end
    mid = array.size / 2
    left = merge_sort(array[0...mid])
    right = merge_sort(array[mid...array.size])
    sort(left, right)
  end

  def sort(left, right)
    results = []
    while left.length > 0 && right.length > 0
      if left[0] < right[0]
        results << left[0]
        left.delete_at(0)
      else
        results << right[0]
        right.delete_at(0)
      end
    end
    results += left
    results += right
    results
  end
end

sort = MergeSort.new
array = [1, 3, 5, 7, 9, 2, 4, 6, 8, 0]
puts sort.merge_sort(array)