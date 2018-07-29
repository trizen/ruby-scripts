#!/usr/bin/ruby

# Recursive algorithm for determining if a given number is a happy number.

# See also:
#   https://en.wikipedia.org/wiki/Happy_number
#   https://rosettacode.org/wiki/Happy_numbers

@cache = {}

def is_happy(n, seen={})

    return false if (n < 1)
    return true if (n == 1)
    return false if seen[n]
    return @cache[n] if @cache.has_key?(n)

    seen[n] = true
    @cache[n] = is_happy(n.digits.map{|n| n*n }.sum, seen)
end

for n in (1..100)
    puts n if is_happy(n)
end
