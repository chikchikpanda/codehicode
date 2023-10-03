def selection_sort(A):  #passing the array as function argument
   n = len(A) #taking length of given array to find total passes to carry
   for i in range(0, n):  # loop 1,for making passes to check elements
       min_i = i   # assigning 0th index as minimum,and then above indexes in above passes
       for j in range(i + 1, n):  # loop 2,checking elements to get the minimum
           if A[j] < A[min_i]:  # checking assigned minimum against all elements
               min_i = j   # if something less found,assigning it as minimum
       A[i], A[min_i] = A[min_i], A[i]    # swapping elements
   print(A)  # at last,printing sorted array,after all passes
