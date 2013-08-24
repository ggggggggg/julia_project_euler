start_time = time()
n = factorial(2)^1000
total = 0
while n > 0
    total += mod(n, 10)
    n = div(n, 10)
end
@printf("total = %s, elapsed time = %0.6f", string(total), time()-start_time)
