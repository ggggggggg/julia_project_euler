# 21 22 23 24 25
# 20  7  8  9 10
# 19  6  1  2 11
# 18  5  4  3 12
# 17 16 15 14 13
# diagonals are 1 3 5 7 9 13 17 21 25

total = 1
q = 1
stride = 2
r = 1

while stride <= 1000
    if r == 5
        r = 1
        stride +=2
    end
    q+=stride
    total+=q
    r+=1
    println(q)
end

println(total-q)
