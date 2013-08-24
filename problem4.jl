function gen_palindromes()
    palindromes = [1]
    for i=0:9, j=0:9, k=0:9
        palindromes = [palindromes i*(10^5+1)+j*(10^4+10^1)+k*(10^3+10^2)]
    end
return palindromes
end

function gen_products_of_3_digit_numbers()
    products = zeros(Int32, 999*999)
    for i=1:999, j=1:999
        products[i + (j-1)*999]=i*j
    end
return products
end

function is_palindrome(a)
    return string(a) == string(a)[end:-1:1]
end
palindromes = gen_palindromes()
products = gen_products_of_3_digit_numbers()

product_palindromes = sort(unique(products[find([contains(palindromes, x) for x in products])]))
#product_palindromes = products[find([is_palindrome(x) for x in products])]
println(max(product_palindromes))
