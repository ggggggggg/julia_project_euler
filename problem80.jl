function digitsum(x,num_digits)
    ds::BigFloat = -floor(x)
    for i = 1:num_digits+1
        d = floor(x)
        x = 10*(x-d)
        ds+=d
    end
return ds
end

set_bigfloat_precision(300)
x=sqrt(BigFloat(2))
println(digitsum(x,10))
