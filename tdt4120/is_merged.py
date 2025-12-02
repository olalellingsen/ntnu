
def is_merged(A, B, X):

    m = len(A)
    n = len(B)

    x1 = X[0:m]
    x2 = X[m+1:]

    merged = False

    for i in range(0,n):
        for j in range(0,m):
            if x1[j] == B[i]:
                merged = True
            
                



A = [1,2,3,4]
B = [5,6,7,8,9,10]

X = [5,1,2,6,7,3,8,4,9,10]

is_merged(A,B,X)
