function ways(x,y)
    x,y = sort([x,y])
    if x == 0
        return 1
    else
        return ways(x-1,y) + ways(x,y-1)
    end
end


#println(ways(2,2))


maxval = 20
w = zeros(Int,(maxval,maxval))


for x = 1:20, y=1
    w[x,y] = ways(x,y)
    w[y,x] = w[x,y]
end

for x = 2:maxval, y = x:maxval
    w[x,y] = w[x-1, y]+w[x,y-1]
    w[y,x] = w[x,y]
end

println(w[maxval, maxval])
