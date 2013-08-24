#[a*b*c for a = 1:1000, b=a:1000-a c=b+a:1000-a-b]


for a = 1:1000, b=a:1000-a
    c = 1000-b-a
    if a^2+b^2==c^2
        println(a*b*c)
    end
end

[a^2+b^2==(1000-a-b)^2 ? println(a*b*(1000-a-b)):1 for a = 1:1000, b=1:1000]
