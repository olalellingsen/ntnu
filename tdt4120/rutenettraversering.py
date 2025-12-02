
def f(x, y):

    A = [1] * y
    for j in range(1, x):
        B = [1] * y
        for i in range(1, y):
            B[i] = A[i] + B[i-1]
        A = B   
    
    return A[-1]

    


print(f(5,7))
