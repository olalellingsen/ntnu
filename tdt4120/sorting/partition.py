
def partition(A, p, r):
    x = A[r]
    i = 0
    for j in range(p, r):
        if A[j] <= x:
            #exchange A[i] and A[j]
            new_j = A[i]
            A[i] = A[j] 
            A[j] = new_j
            i += 1
    #exchange A[i] and A[r]
    new_r = A[i]
    A[i] = A[r] 
    A[r] = new_r
    return i + 1


arr = [2,8,7,1,3,5,6,4]

print(partition(arr,0,7))
