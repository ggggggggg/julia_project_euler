start_time = time()

function find_prime_sieve(max_prime)
    is_prime = falses(max_prime)
    mod60 = mod([1:max_prime],60)
    max_x = int(ceil(sqrt(max_prime)))
    for x = 1:max_x, y=1:max_x
        n = 4*x^2+y^2
        if n <= max_prime
            if contains([1 13 17 29 37 41 49 53], mod60[n])
                is_prime[n] = !is_prime[n]
            end
        end
        n = 3*x^2+y^2
        if n <= max_prime
            if contains([7 19 31 43], mod60[n])
                is_prime[n] = !is_prime[n]
            end
        end
        if x>y
            n = 3*x^2-y^2
            if n <= max_prime
                if contains([11 23 47 59], mod60[n])
                    is_prime[n] = !is_prime[n]
                end
            end
        end
    end
    for n = 5:max_prime
        if is_prime[n]
            num_squares = int(floor(max_prime/n^2))
            for i = 1:num_squares
                is_prime[i*n^2] = false
            end
        end
    end
is_prime[1:5] = [false true true false true]
return is_prime
end
max_prime = 10^6
primes = find(find_prime_sieve(max_prime))

max_sum_length = 0
max_sum = 0
max_sum_prime = 0
max_sum_start_prime = 0
for (q,prime) in enumerate(primes)
    sum_length = 0
    consecutive_sum = 0
    for (r,prime_b) in enumerate(primes[q:end])
        consecutive_sum += prime_b
        contains(primes, consecutive_sum) ? sum_length = r : 0
        consecutive_sum >= max_prime ? break : 0
    end
    if sum_length > max_sum_length
        max_sum_length, max_sum_prime, max_sum_start_prime = sum_length, sum(primes[q:q+sum_length-1]), prime
    end
    mod(q,1000) == 0 ? println(prime) : 0
end

@printf("sum_length %d starting at %d gives prime %d",max_sum_length,max_sum_start_prime, max_sum_prime)
