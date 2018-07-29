#!/usr/bin/ruby

# Convert roman numerals to arabic numbers.

# See also:
#   https://en.wikipedia.org/wiki/Roman_numerals

def roman2arabic(roman)

    arabic     = 0
    last_digit = 1000

    m = {
        I:    1,
        V:    5,
        X:   10,
        L:   50,
        C:  100,
        D:  500,
        M: 1000,
    }

    for digit in (roman.chars.map {|n| m[n.to_sym] })
        if (last_digit < digit)
            arabic -= (last_digit << 1)
        end
        arabic += (last_digit = digit)
    end

    return arabic
end

puts roman2arabic("MCMXC")      #=> 1990
puts roman2arabic("MMVIII")     #=> 2008
puts roman2arabic("MDCLXVI")    #=> 1666
