import math

# A tabell
# p venstre
# r høyre
# v søkeverdi
# q midten

def bisect(A, p, r, v): 
    if p <= r:
        q = math.ceil((p+r)/2)
        if v == A[q]:
            return q # returnerer indeksen til søkeverdien
        elif v <= A[q]:
            return bisect(A, p, q-1, v) # leter til venstre
        else:
            return bisect(A, q+1, r, v) # leter til høyre
    return None


array = [1, 2, 2, 3, 3, 4, 5, 6, 7]

p = array[0]
r = array[-1]

v = 6 

print(bisect(array, p, r, v))

