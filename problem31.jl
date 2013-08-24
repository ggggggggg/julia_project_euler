coinvals = [1 2 5 10 20 50 100 200]
max_value = 200
function values(coinval, max_value)
    return [coinval:max_value]
ways = Dict()
for value = 0:max_value
    ways[value] = BigInt(0)
end

for
coinval_index = 0
for value in 1:200
    contains(coinvals, value) ? coinval_index += 1 : 0
    for ci in 1:coinval_index
        ways[value+1] += ways[value-coinvals[ci]+1]
    end
end

println(ways)
