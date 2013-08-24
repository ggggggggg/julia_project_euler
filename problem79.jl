s = reshape(int(split(join(split("319
680
180
690
129
620
762
689
762
318
368
710
720
710
629
168
160
689
716
731
736
729
316
729
729
710
769
290
719
680
318
389
162
289
162
718
729
319
790
680
890
362
319
760
316
729
380
319
728
716")),"")), (3,50))

digits = union(s,s)

must = zeros(Int, (10,10)) # there are must[1,5] instances where 0 must occur before 4
for q = 1:50
    must[s[1,q]+1,s[2,q]+1]+=1
    must[s[2,q]+1,s[3,q]+1]+=1
    must[s[1,q]+1,s[3,q]+1]+=1
end



p = [7,3,1,6,2,8,9,0]
for q = 1:50
    a = findfirst(p,s[1,q])
    a == 0 ? println("missing $(s[1,q])") : 0
    b = findfirst(p[max(a,1):], s[2,q])
    b == 0 ? println("missing $(s[2,q]) after $(s[1,q])") : 0
    c = findfirst(p[max(b,1):], s[3,q])
    b == 0 ? println("missing $(s[3,q]) after $(s[2,q])  after $(s[1,q])") : 0
end


xin = setdiff([0:9],p)
for x in xin, y=1:9
    if must[x+1,y+1] > 0 || must[y+1,x+1] > 0
        println("$x before $y: $(must[x+1,y+1]), $y before $x: $(must[y+1,x+1])")
    end
end
for y in fliplr(xin), x=1:9
    if must[x+1,y+1] > 0 || must[y+1,x+1] > 0
        println("$y after $x: $(must[x+1,y+1]), $x after $y: $(must[y+1,x+1])")
    end
end


p = s[:,1] # first 3 ordered digits
function try_d(s, p)
    if s == None
        return p
    end
    numleft = size(s)[2]
    if numleft == 1
        s, s_sub = s[:,1], None
    else
        s, s_sub = s[:,1], s[:,2:]
    end
    i, ilast = 0,0
    for q = 1:3
        i, ilast = findfirst(p,s[q]), i
        if i == 0
            for insertloc = 1:length(p)+1
                println("$p inserting $(s[q]) at $insertloc with $numleft left")
                pp = copy(p)
                insert(pp, insertloc, s[q])
                pp_result = try_d(s_sub,pp)
                if (pp_result == false)
                    continue
                end
            end
        elseif ilast>i
            return false
        end
    end
return try_d(s_sub, p)
throw(error("got to end"))
end # this probably works for passcodes without repeated digits

#a = try_d(s,p)

