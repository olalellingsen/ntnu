
def k_largest(A, n, k):

    # finn max
    
    maks = A[0]
    for i in range(1, n-1):
        if maks < A[i]:
            maks = A[i]
    
    # sorter listen
    A = counting_sort(A, n, maks)

    # returner listen fra A[n - k] til A[n]
    return A[n-k:n]



def counting_sort(A, n, k):
    B = [0] * n
    C = [0] * (k + 1)

    for j in range(0, n):
        C[A[j] - 1] += 1

    for i in range(1, k + 1):
        C[i] += C[i - 1]

    for j in range(n - 1, -1, -1):
        B[C[A[j] - 1] - 1] = A[j]
        C[A[j] - 1] -= 1

    return B

arr1 = [0, 2047, 0, 2047]

counting_sort(arr1, 4, 2048)

# arr = [2,1,5,3,1,3,5,2,1,6,4,2]

# print(k_largest(arr, len(arr), 3))

