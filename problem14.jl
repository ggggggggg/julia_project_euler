function collatz_step(n)
    if mod(n,2) == 0
        return n/2
    else
        return 3*n+1
    end
end

function collatz(n)
    q = 1
    while n > 1
        n = collatz_step(n)
        q += 1
    end
return q
end

max_steps = 0
n_max_steps = 0
for n in 1:10^6
    steps = collatz(n)
    if steps > max_steps
        max_steps = steps
        n_max_steps = n
    end
end
println(n_max_steps)
