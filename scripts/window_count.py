def window_count(l,bin):
    dict = {}
    index = 1
    while index <= 1+len(l)-bin:
        dict[index] = sum(list(l[index-1:index+bin-1]))
        index = index+1
    print(dict)

# Here is the example
l = [0.3,0.8,0.7,0.4,0.2]
window_count(l,3)
