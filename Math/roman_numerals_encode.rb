#!/usr/bin/ruby

# Convert arabic integers to roman numerals.

# See also:
#   https://en.wikipedia.org/wiki/Roman_numerals

def arabic2roman(num)

    lookup = {
         M:1000, CM:900,   D:500,
        CD:400,   C:100,  XC:90,
         L:50,   XL:40,    X:10,
        IX:9,     V:5,    IV:4,
         I:1
    }

    roman = ''

    lookup.each {|k,v|
        while (num >= v)
            roman << k.to_s
            num -= v
        end
    }

    return roman
end

puts arabic2roman(1990)     #=> MCMXC
puts arabic2roman(2008)     #=> MMVIII
puts arabic2roman(1666)     #=> MDCLXVI
