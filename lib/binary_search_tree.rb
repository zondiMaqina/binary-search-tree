require_relative 'merge_sort'
array = [1, 3, 5, 7, 9, 2, 4, 6, 8, 0]
sort = MergeSort.new
puts sort.merge_sort(array)