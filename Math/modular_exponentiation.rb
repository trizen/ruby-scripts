#!/usr/bin/ruby

# Modular exponentation (by squaring) algorithm.

# See also:
#   https://en.wikipedia.org/wiki/Modular_exponentiation

def expmod(a, b, n)
    c = 1

    while (true)

        if (b.odd?)
            c *= a
            c %= n
        end

        a *= a
        a %= n
        b >>= 1

        break if b.zero?
    end

    return c
end

puts expmod(
    2988348162058574136915891421498819466320163312926952423791023078876139,
    2351399303373464486466122544523690094744975233415544072992656881240319,
    10**40
)
