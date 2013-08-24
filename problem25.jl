function factorial_gen()
    x,y = BigInt(1),BigInt(1)
    while true
        f = x+y
        x,y = y,f
        produce(f)
    end
end

factorials = Task(factorial_gen)

maxVal = BigInt(10)^999
q = 3
for f in factorials
    if f >= maxVal
        break
    end
    q+=1
end
@printf("q = %d", q)
