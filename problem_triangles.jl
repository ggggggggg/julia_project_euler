totalL = 0
numfound = 0
m=0
while numfound < 12
    m+=1
    # from (2b-a)^2=1
    #n1 = -sqrt(5*m^2-1)-2m
    n2 = sqrt(5*m^2-1)-2m
    #n3 = -sqrt(5*m^2+1)-2m
    n4 = sqrt(5*m^2+1)-2m
    # from (2a-b)^2=1, solutions from wolfram alpha
    #n5 = 0.5*(-sqrt(5m^2-2)-m)
    #n6 = 0.5*(sqrt(5m^2-2)-m)
    #n7 = 0.5*(-sqrt(5m^2+2)-m)
    #n8 = 0.5*(sqrt(5m^2+2)-m)
    nall = int(round([n2,n4]))
    err = abs([n2,n4]-nall)
    for i = 1:length(nall)
        n = nall[i]
        if n > 0 && err[i] < 1e-10
            a,b,c = m^2-n^2, 2m*n, m^2+n^2
            numfound+=1
            println("#$numfound $i $(a,b,c) $(err[i]) $(abs(2b-a))")
            totalL+=c
        end
    end
end


println(totalL)

