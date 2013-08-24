function faery_coprime_pairs(n)
    a,b,c,d = 0,1,1,n
    produce((a,b))
    while c <= n
        k = div((n+b),d)
        a,b,c,d = c,d,k*c-a, k*d-b
        produce((a,b))
    end
end

function coprime_pairs(m,n,max_mn)
    produce((m,n))
    if n < max_mn && m < max_mn
        coprime_pairs(2m-n,m,max_mn)
        coprime_pairs(2m+n,m,max_mn)
        coprime_pairs(m+2n,n,max_mn)
    end
end


coprime = Task(()->faery_coprime_pairs(10000))

start_time = time()
totalL = 0
x=0
for pair in coprime
    (m,n) = pair
    a,b,c=sort([m^2-n^2, 2m*n, m^2+n^2])
    #println("$(m,n) $(a,b,c) $(2a-b) $(abs(2a-b)) $(abs(2a-b) == 1)")
    if abs(2a-b) == 1
        println((a,b,c))
        totalL+=2a+2c
        x+=1
    end
    if x>=4
        break
    end
end

println(totalL)
println(time()-start_time)

n = 1000
a,b,c,d = 0,1,1,n
while c <= n
    k = div((n+b),d)
    a,b,c,d = c,d,k*c-a, k*d-b
    m,n = a,b
    abc = sort([m^2-n^2, 2m*n, m^2+n^2])
    if abs(2abc[1]-abc[2]) == 1
        println(abc
        totalL+=2abc[1]+2abc[3]
        x+=1
    end
    if x==12
        break
    end
end
