#!/usr/bin/ruby

# Determine if a number is a perfect square, using the binary search algorithm.

# See also:
#   https://en.wikipedia.org/wiki/Square_number

def is_perfect_square(n)

    return false if (n <= 0)
    return true  if (n == 1)

    left  = 1
    right = n>>1

    while (left <= right)
        middle = (left+right)>>1
        square = middle*middle

        if (square == n)
            return true
        elsif (square < n)
            left = middle+1
        else
            right = middle-1
        end
    end

    return false
end

for n in (1..100)
    puts n if is_perfect_square(n)
end
