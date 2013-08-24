start_time = time()

function find_prime_sieve(maxPrime)
    isPrime = falses(maxPrime)
    mod60 = mod([1:maxPrime],60)
    maxX = int(ceil(sqrt(maxPrime)))
    for x = 1:maxX, y=1:maxX
        n = 4*x^2+y^2
        if n <= maxPrime
            if contains([1 13 17 29 37 41 49 53], mod60[n])
                isPrime[n] = !isPrime[n]
            end
        end
        n = 3*x^2+y^2
        if n <= maxPrime
            if contains([7 19 31 43], mod60[n])
                isPrime[n] = !isPrime[n]
            end
        end
        if x>y
            n = 3*x^2-y^2
            if n <= maxPrime
                if contains([11 23 47 59], mod60[n])
                    isPrime[n] = !isPrime[n]
                end
            end
        end
    end
    for n = 5:maxPrime
        if isPrime[n]
            numSquares = int(floor(maxPrime/n^2))
            for i = 1:numSquares
                isPrime[i*n^2] = false
            end
        end
    end
isPrime[1:5] = [false true true false true]
return isPrime
end

function trianglular_numbers_iter()
    number = 0
    i=1
    while true
        number = number+i
        i=i+1
        produce(number)
    end
end


function factor(n, primes)
    divisor_index = 1
    divisor_dict = Dict()
    while primes[divisor_index] <= n
        i = 0
        while mod(n, primes[divisor_index]) == 0
            n = n/primes[divisor_index]
            i += 1
        end
        i>0 ? divisor_dict[primes[divisor_index]] = i : 0
        divisor_index +=1
    end
    return divisor_dict
end

function count_divisors(n, primes)
    divisor_dict = factor(n, primes)
    num_divisors = 1
    for d in divisor_dict
        num_divisors *= d[2]+1
    end
    return num_divisors
end

numbers = Task(trianglular_numbers_iter)
primes = find(find_prime_sieve(10^6))

start_time_noprime = time()
for number in numbers
    num_divisors = count_divisors(number, primes)
    if num_divisors>500
        @printf("%d is a triangular number with %d divisors", number, num_divisors)
        break
    end
end
@printf("elapsed time = %0.1f ms\n", 1000*(time()-start_time))
@printf("elapsed time = %0.1f ms, excluding prime generation", 1000*(time()-start_time_noprime))

function remake(divisor_dict)
    product = 1
    for d in divisor_dict
        product *= d[1]^d[2]
    end
return product
end

#d = factor(10, primes)
#remake(d)
#count_divisors(10, primes)
#for number in numbers
#    if count_divisors(number) > 500
#        println(number)
#    end
#end
