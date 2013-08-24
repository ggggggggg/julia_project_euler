function rect_degen(main, sub)
    if main[1] >= sub[1] && main[2] >= sub[2]
        return (main[1]-sub[1]+1)*(main[2]-sub[2]+1)
    else
        throw(error("$sub doesnt fit in $main"))
    end
end

function num_sub_rects(main)
    sub_rects = 0
    for m = 1:main[1], n=1:main[2]
        #println("$(m,n) -> $(rect_degen(main, (m,n)))")
        sub_rects += rect_degen(main, (m,n))
    end
return sub_rects
end

function binary_search(func, target, xmin, xmax)
    xmid=0
    while xmax-xmin > 1
        xmid = int(round((xmin+xmax)/2))
        fmid = func(xmid)
        if fmid < target
            xmin = xmid
        elseif fmid > target
            xmax = xmid
        elseif fmid == target
            return xmax
        end
        println("$(xmin, xmid, xmax)")
    end
    x = [max(xmid-1,1), xmid, xmid+1]
    println("$x last chance")
    err = int([abs(func(xm)-target) for xm in x])
    println("$err last chance")
    return x[indmin(err)]
throw(error("failed search"))
end

target = 2000000
maxm = 100
func = 0
best_diff = Inf
bestn = zeros(Int, maxm)
err = zeros(Int, maxm)
for m = 1:maxm
    #println(m)
    func = (n)->num_sub_rects((m,n))
    bestn_temp = binary_search(func, target, 0, 3000)
    bestn_rects = num_sub_rects((m,bestn_temp))
    d = abs(target-bestn_rects)
    err[m]=d
    bestn[m] = bestn_temp
end
bestm = indmin(err)

println("$(bestm, bestn[bestm]) is has closest to $target rectangles, with $(target+err[bestm])")
