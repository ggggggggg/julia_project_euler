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
function are_permutation(nums)
    @assert(length(nums)>1)
    digit_count = digits(first(nums))
    for n in nums[2:]
        dc = digits(n)
        if dc != digit_count
            return false
        end
    end
    return true
end
function digits(n::Int)
    digit_count = zeros(Int32,10)
    while n > 0
        digit = mod(n,10)
        n = div(n,10)
        digit_count[digit+1]+=1
    end
    return digit_count
end



max_prime = 10^4
primes = find(find_prime_sieve(max_prime))
q_offset = first(find(map((x)->x>999, primes)))
for (q,prime) in enumerate(primes[q_offset:end-2])
    for (r,prime_b) in enumerate(primes[q_offset+q+1:end])
        pdiff = prime_b-prime
        if contains(primes, prime_b+pdiff)
            are_permutation([prime prime_b prime_b+pdiff]) ? println("$prime $prime_b $(prime_b+pdiff)") : 0
        end
    end
end

