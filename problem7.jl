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


primes = find(find_prime_sieve(10^6))

println(primes[10001])
