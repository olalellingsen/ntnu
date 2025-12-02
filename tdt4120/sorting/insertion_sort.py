
def insertion_sort(A):
    for i in range(1, len(A)):
        key = A[i]
        j = i-1
        while j >= 0 and A[j] > key:
            A[j+1] = A[j]
            j = j-1
        A[j+1] = key
    

array = [3, 13, 32, 12, 24, 53, 2, 43, 21, 34]

print(f"Usortert: {array}")

insertion_sort(array)

print(f"Sortert: {array}")

