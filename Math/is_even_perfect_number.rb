#!/usr/bin/ruby

# Daniel "Trizen" Șuteu
# Date: 29 July 2018
# https://github.com/trizen

# Efficient verification for an even perfect number, using the Lucas-Lehmer test.

# See also:
#   https://en.wikipedia.org/wiki/Perfect_number
#   https://en.wikipedia.org/wiki/Mersenne_prime
#   https://en.wikipedia.org/wiki/Lucas%E2%80%93Lehmer_primality_test

def lucas_lehmer(p)

    return true if (p == 2)

    m = ((1<<p) - 1)
    s = 4

    (p-2).times do
        s = (((s*s)%m) - 2)
    end

    s == 0
end

def is_even_perfect(n)

    return false if (n <= 5)
    return false if (n.odd?)

    v = 0
    while (n.even?)
        v += 1
        n >>= 1
    end

    m = 1+n
    return false unless ((m &  (m-1)) == 0)
    return false unless ((m >> (v+1)) == 1)

    lucas_lehmer(v+1)
end

puts is_even_perfect(191561942608236107294793378084303638130997321548169216)                            # true
puts is_even_perfect(191561942608236107294793378084303638130997321548169214)                            # false
puts is_even_perfect(191561942608236107294793378084303638130997321548169218)                            # false
puts is_even_perfect(14474011154664524427946373126085988481573677491474835889066354349131199152128)     # true

# A much larger perfect number
puts is_even_perfect(141053783706712069063207958086063189881486743514715667838838675999954867742652380114104193329037690251561950568709829327164087724366370087116731268159313652487450652439805877296207297446723295166658228846926807786652870188920867879451478364569313922060370695064736073572378695176473055266826253284886383715072974324463835300053138429460296575143368065570759537328128)

# Search test
for n in (1..10000)
    puts n if is_even_perfect(n)
end
